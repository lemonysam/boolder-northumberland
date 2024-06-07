class MakeGradeTypeEnum < ActiveRecord::Migration[7.1]
  def change
    change_column :grades, :grade_type, 'integer USING CAST(grade_type AS integer)'
  end
end
