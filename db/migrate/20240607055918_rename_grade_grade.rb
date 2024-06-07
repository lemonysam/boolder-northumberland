class RenameGradeGrade < ActiveRecord::Migration[7.1]
  def change
    rename_column :grades, :grade, :name
  end
end
