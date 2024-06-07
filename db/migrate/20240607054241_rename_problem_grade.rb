class RenameProblemGrade < ActiveRecord::Migration[7.1]
  def change
    rename_column :problems, :grade, :grade_name
  end
end
