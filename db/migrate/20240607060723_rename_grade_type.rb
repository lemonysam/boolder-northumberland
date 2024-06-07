class RenameGradeType < ActiveRecord::Migration[7.1]
  def change
    rename_column :grades, :type, :grade_type
  end
end
