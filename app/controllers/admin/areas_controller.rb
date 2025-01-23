require 'csv'
class Admin::AreasController < Admin::BaseController
  def index
    sort = params[:sort] == "id" ? :id : :name
    @areas = Area.order(sort)
  end

  def edit
    set_area
  end

  def new
    @area = Area.new
  end

  def create
    area = Area.new
    area.assign_attributes(area_params)

    area.save!

    flash[:notice] = "Area created"
    redirect_to [:admin, area]
  end


  def show
    set_area
    redirect_to admin_area_problems_path(@area, circuit_id: 'first')
  end

  def update
    set_area
    
    @area.assign_attributes(area_params)
    @area.tags = params[:area][:joined_tags].split(',')

    if cover = params[:area][:cover]
      @area.cover = params[:area][:cover]
    end

    if @area.save
      flash[:notice] = "Area updated"
      redirect_to edit_admin_area_path(@area)
    else
      flash[:error] = @area.errors.full_messages.join('; ')
      render "edit", status: :unprocessable_entity
    end
  end

  def export
    area = Area.find_by(slug: params[:area_slug])
    csv_data = CSV.generate(headers: true) do |csv|
      csv << %w"id areaId name grade secondary_grade steepness height sit_start description_en history_note"

      area.problems.each do |p|
        csv << [p.id, area.id, p.name, p.grade_name, p.secondary_grade, p.steepness, p.height, p.sit_start, p.description_en, p.history_note]
      end
    end

    send_data csv_data, filename: "#{area.slug}.csv"
  end

  private 
  def area_params
    params.require(:area).
      permit(:name, :slug, :published, :priority, :short_name, :description_fr, :description_en, :warning_fr, :warning_en)
  end

  def set_area
    @area = Area.find_by(slug: params[:slug])
  end
end
