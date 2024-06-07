class Admin::ProblemImportsController < Admin::BaseController
  def create
    files = params[:import][:csv].select{|f| f.present? }

    files.sort_by{|file| file.original_filename }.each do |file|
      array = CSV.parse(file.read, headers: true)
      array.each do |hash|
        problem = Problem.new(
          area: Area.find(hash["areaId"].to_i),
          name: hash["name"],
          steepness: hash["steepness"].present? ? hash["steepness"].to_sym : :other,
          height: hash["height"],
          sit_start: hash["sit_start"] == "true",
          description_en: hash["description_en"],
          history_note: hash["history_note"],
        )
        @problem.grade = Grade.find { |g| g.name == hash["grade"] && g.grade_type == hash["grade"]} #todo, make flexible

        problem.save!
      end
    end

    flash[:notice] = "#{files.count} problems updated"
    redirect_to new_admin_problem_import_path
  rescue => err
    flash[:error] = err.message
    redirect_to new_admin_problem_import_path
  end
end
