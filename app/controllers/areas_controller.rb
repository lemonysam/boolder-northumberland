class AreasController < ApplicationController
  def index
    # see https://guides.rubyonrails.org/caching_with_rails.html#avoid-caching-instances-of-active-record-objects
    @popular_areas_ids = Rails.cache.fetch("areas/index/popular_areas_ids", expires_in: 12.hours) do
      Area.published.any_tags(:popular).pluck(:id).shuffle
    end

    @areas_with_count = Area.published.sort_by{|a| I18n.transliterate(a.name) }
  end

  def levels
    # see https://guides.rubyonrails.org/caching_with_rails.html#avoid-caching-instances-of-active-record-objects
    @beginner_areas_ids = Rails.cache.fetch("areas/levels/beginner_areas_ids", expires_in: 12.hours) do
      Area.beginner_friendly.pluck(:id)
    end

    @areas_with_count = Area.published.map {|area| [area, area.problems.with_location.count]}.sort{|a,b| b.second <=> a.second }
  end

  def show
    @area = Area.find_by!(slug: params[:slug])

    @circuits = @area.main_circuits

    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})

    @popular_problems = @area.problems.with_location.ordered_by_grade.where(featured: true)
  end

  def problems
    @area = Area.find_by(slug: params[:slug])
    
    @problems = @area.problems.with_location.order(popularity: :desc).group_by{|p| p.grade.name }.sort_by{|grade, _| grade }.reverse
  end
end
