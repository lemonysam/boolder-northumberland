class Area < ApplicationRecord
  has_many :boulders
  has_many :problems, -> { includes :grade }
  has_many :circuits, -> { distinct }, through: :problems
  has_many :poi_routes
  # belongs_to :bleau_area

  has_one_attached :cover do |attachable|
    attachable.variant :thumb, resize_to_limit: [400, 400], saver: { quality: 80, strip: true, interlace: true }, preprocessed: true
    attachable.variant :medium, resize_to_limit: [800, 800], saver: { quality: 80, strip: true, interlace: true }, preprocessed: true
  end

  audited

  scope :published, -> { where(published: true) }
  include HasTagsConcern

  normalizes :name, :short_name, :description_fr, :description_en, :warning_fr, :warning_en, with: -> s { s.strip.presence }

  validates :tags, array: { inclusion: { in: %w(popular beginner_friendly family_friendly dry_fast) } }
  validates :slug, presence: true

  # reindex problems on algolia when area is updated
  # https://github.com/algolia/algoliasearch-rails#propagating-the-change-from-a-nested-child
  after_save { problems.each(&:touch) if saved_change_to_attribute?(:published) || saved_change_to_attribute?(:name) } 

  include AlgoliaSearch
  algoliasearch if: :published, enqueue: true, disable_indexing: Rails.env.local? do
    attributes :name, :priority
    attribute :bounds do 
      { 
        south_west: { lat: bounds[:south_west]&.lat || 0.0, lng: bounds[:south_west]&.lon || 0.0 },
        north_east:  { lat: bounds[:north_east]&.lat || 0.0, lng: bounds[:north_east]&.lon || 0.0 },
      }
    end
    searchableAttributes [:name]
    customRanking ['asc(priority)']
  end

  def levels
    @levels ||= 1.upto(8).map{|level| [level, problems.with_location.level(level).count >= 15] }.to_h
  end

  def self.beginner_friendly
    published.any_tags(:beginner_friendly).
      map {|area| [area, area.problems.with_location.count]}.sort{|a,b| b.second <=> a.second }.map(&:first).
      sort_by{|a| -a.circuits.select(&:beginner_friendly?).length }
  end

  def self.with_ids_keep_order(ids)
    where(id: ids).sort_by{|a| ids.index(a.id)}
  end

  def to_param
    slug
  end

  def name_debug
    [id, name].join(" - ")
  end

  def bounds
    relevant_boulders = boulders.where(ignore_for_area_hull: false)
    @bounds ||= {
      south_west: FACTORY.point(relevant_boulders.minimum("st_xmin(polygon::geometry)"), relevant_boulders.minimum("st_ymin(polygon::geometry)")),
      north_east: FACTORY.point(relevant_boulders.maximum("st_xmax(polygon::geometry)"), relevant_boulders.maximum("st_ymax(polygon::geometry)"))
    }
  end

  # TODO: rewrite in SQL
  def main_circuits
    circuits.select{|c| c.problems.where(area_id: id).count >= 10 }.sort_by(&:average_grade)
  end

  def sorted_circuits
    circuits.sort_by(&:average_grade)
  end
end
