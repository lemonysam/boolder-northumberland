class Admin::ProblemsController < Admin::BaseController
  def index
    @area = Area.find_by(slug: params[:area_slug])

    if params[:circuit_id] == "first" && (id = @area.sorted_circuits.first&.id)
      redirect_to admin_area_problems_path(area_slug: @area.slug, circuit_id: id) 
    end

    arel = Problem.where(area_id: @area.id) 

    arel = if params[:circuit_id].to_i > 0
      arel.where(circuit_id: params[:circuit_id]).sort_by(&:enumerable_circuit_number) if params[:circuit_id].present?
    else
      arel.order("ascents DESC NULLS LAST")
    end

    arel = if params[:missing] == "line"
      arel.without_line_only
    elsif params[:missing] == "location"
      arel.without_location
    else
      arel
    end

    @problems = arel

    circuits = @area.sorted_circuits
    @circuit_tabs = circuits.map{|c| [c.id, c.name] }.push([nil, "All"])

    @missing_grade = @area.problems.without_grade
  end

  def new
    area = Area.find(params[:area_id])

    @problem = Problem.new(steepness: :other)

    @problem.area = area
    @circuits = area.sorted_circuits
  end

  def create
    problem = Problem.new
    problem.assign_attributes(problem_params)
    problem.grade = Grade.find { |g| g.name == problem_params[:grade_name] }

    problem.save!

    flash[:notice] = "Problem created: #{view_context.link_to('view problem', [:admin, problem], class: 'underline')}."
    redirect_to new_admin_problem_path(area_id: problem.area_id)
  end

  def show
    set_problem
  end

  def edit
    set_problem
  end

  def update
    set_problem

    @problem.assign_attributes(problem_params)

    @problem.grade = Grade.find { |g| g.name == problem_params[:grade_name] }
    
    if @problem.save
      flash[:notice] = "Problem updated"
      redirect_to admin_problem_path(@problem)
    else
      flash[:error] = @problem.errors.full_messages.join('; ')
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    problem = Problem.find(params[:id])
    problem.destroy!

    flash[:notice] = "Problem destroyed"
    redirect_to admin_area_path(problem.area)
  end

  private 
  def problem_params
    params.require(:problem).
      permit(:area_id, :name, :grade_name, :steepness, :sit_start, :secondary_grade,
        :bleau_info_id, :circuit_number, :circuit_letter, :circuit_id, :parent_id, :description_en, :history_note
      )
  end

  def set_problem
    @problem = Problem.find(params[:id])
    @circuits = @problem.area.sorted_circuits
  end
end
