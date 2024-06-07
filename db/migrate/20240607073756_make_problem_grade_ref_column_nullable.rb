class MakeProblemGradeRefColumnNullable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :problems, :grade_id, true
  end
end
