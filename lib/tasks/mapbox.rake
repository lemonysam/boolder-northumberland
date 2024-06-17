require 'rgeo/geo_json'
require 'aws-sdk-s3'
require 'aws-sdk-core'

namespace :mapbox do
  task areas: :environment do
    ExportAreasJob.perform_now
  end

  task problems: :environment do
    ExportProblemsJob.perform_now
  end

  task circuits: :environment do 
    factory = RGeo::GeoJSON::EntityFactory.instance

    circuit_features = Circuit.all.map do |circuit|
      problems = circuit.problems.exclude_bis.with_location.sort_by(&:enumerable_circuit_number)
      line_string = FACTORY.line_string(problems.map(&:location))
      factory.feature(line_string, nil, { id: circuit.id, color: circuit.color })
    end

    feature_collection = factory.feature_collection(
      circuit_features
    )

    geo_json = RGeo::GeoJSON.encode(feature_collection)

    File.open(Rails.root.join("tmp", "boolder-maps", "mapbox", "circuits.geojson"),"w") do |f|
      f.write(JSON.pretty_generate(geo_json))
    end

    puts "exported circuits.geojson".green
  end

  # TODO: Revamp the pois task once we migrate to the new POI data model (split pois and poi routes)

  # task pois: :environment do
  #   puts "exporting pois"

  #   factory = RGeo::GeoJSON::EntityFactory.instance

  #   poi_features = Poi.all.reject{|poi| poi.id.in?([10,26]) }.uniq(&:description).map do |poi|
  #     hash = {}.with_indifferent_access
  #     hash[:type] = "parking"
  #     hash[:name] = poi.description
  #     hash[:short_name] = poi.subtitle
  #     hash[:google_url] = poi.google_url
  #     hash.deep_transform_keys! { |key| key.camelize(:lower) }

  #     factory.feature(poi.location, nil, hash)
  #   end

  #   feature_collection = factory.feature_collection(
  #     poi_features
  #   )

  #   geo_json = JSON.pretty_generate(RGeo::GeoJSON.encode(feature_collection))

  #   file_name = Rails.root.join("..", "boolder-maps", "mapbox", "pois.geojson")

  #   raise "file already exists" if File.exist?(file_name)

  #   File.open(file_name,"w") do |f|
  #     f.write(geo_json)
  #   end

  #   puts "exported pois.geojson".green
  # end
end