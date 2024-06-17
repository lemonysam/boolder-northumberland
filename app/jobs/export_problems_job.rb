require 'rgeo/geo_json'
require 'aws-sdk-s3'
require 'aws-sdk-core'

class ExportProblemsJob < ApplicationJob
  queue_as :default
  
  def perform
    puts "exporting problems"

    # raise "please specify a value for include_boulders (true or false). Reminder: don't include boulders when exporting to boolder-data" unless ENV["include_boulders"].present?
    # include_boulders = ENV["include_boulders"] != "false"
    include_boulders = true

    factory = RGeo::GeoJSON::EntityFactory.instance

    problem_features = Problem.with_location.joins(:area).where(area: {published: true}).map do |problem|
      hash = {}.with_indifferent_access
      hash.merge!(problem.slice(:steepness, :featured, :popularity))
      hash[:grade] = problem.grade.name
      hash[:grade_band] = problem.grade.band
      hash[:grade_type] = problem.grade.grade_type
      hash[:id] = problem.id
      hash[:circuit_color] = problem.circuit&.color
      hash[:circuit_id] = problem.circuit_id_simplified
      hash[:circuit_number] = problem.circuit_number_simplified

      name_fr = I18n.with_locale(:fr) { problem.name_with_fallback }
      name_en = I18n.with_locale(:en) { problem.name_with_fallback }
      hash[:name] = name_fr
      hash[:name_en] = (name_en != name_fr) ? name_en : ""

      hash.deep_transform_keys! { |key| key.camelize(:lower) }

      factory.feature(problem.location, nil, hash)
    end

    # Extract boulders alongside problems to ensure we always upload both at the same time to mapbox
    boulder_features = Boulder.where.not(area_id: []).joins(:area).where(area: {published: true}).map do |boulder|
      factory.feature(boulder.polygon, nil, { name: boulder.name })
    end

    if include_boulders
      features = problem_features + boulder_features
    else
      features = problem_features
    end

    feature_collection = factory.feature_collection(
      features
    )

    geo_json = RGeo::GeoJSON.encode(feature_collection)
    file_name = Rails.root.join("tmp", "problems#{"-without-boulders" if !include_boulders}.geojson")
    File.open(file_name, "w") do |f|
      f.write(JSON.pretty_generate(geo_json))
    end

    if Rails.env.production?
      Aws.config.update(
        region: 'eu-west-1',
        credentials: Aws::Credentials.new(
          Rails.application.credentials.dig(:aws, :access_key_id),
          Rails.application.credentials.dig(:aws, :secret_access_key)
        )
      )
      s3 = Aws::S3::Client.new
      s3.put_object(body: open(file_name), bucket: "boolder-northumberland-reports", key: "problems.geojson")
    end

    puts "exported problems.geojson".green
  end
end
