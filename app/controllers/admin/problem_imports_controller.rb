class Admin::ProblemImportsController < Admin::BaseController
  def create
    files = params[:import][:csv].select{|f| f.present? }
    update_count = 0
    create_count = 0
    fail_count = 0
    files.sort_by{|file| file.original_filename }.each do |file|
      array = CSV.parse(file.read, headers: true)
      array.each do |hash|
        if hash["id"]
          problem = Problem.find(hash["id"].to_i)
          problem.area = Area.find(hash["areaId"].to_i)
          problem.name = hash["name"]
          problem.steepness = hash["steepness"].present? ? hash["steepness"].to_sym : :other
          problem.grade = Grade.find { |g| g.name == hash["grade"]}
          problem.grade_name = hash["grade"]
          problem.secondary_grade = hash["secondary_grade"]
          problem.height = hash["height"]
          problem.sit_start = hash["sit_start"] == "true"
          problem.description_en = hash["description_en"]
          problem.history_note = hash["history_note"]
          
          problem.save!

          create_count += 1
        else
          problem = Problem.new(
            area: Area.find(hash["areaId"].to_i),
            name: hash["name"],
            steepness: hash["steepness"].present? ? hash["steepness"].to_sym : :other,
            grade: Grade.find { |g| g.name == hash["grade"]},
            grade_name: hash["grade"],
            secondary_grade: hash["secondary_grade"],
            height: hash["height"],
            sit_start: hash["sit_start"] == "true",
            description_en: hash["description_en"],
            history_note: hash["history_note"],
          ).save!

          update_count += 1
        end
        rescue => err
          fail_count += 1
          flash[:error] = "#{err.message}"
      end
    end

    flash[:success] = "#{create_count} problems created"
    flash[:notice] = "#{update_count} problems updated"
    flash[:error] = "#{fail_count} problems failed #{flash[:error]}"
    redirect_to new_admin_problem_import_path
  end
end
