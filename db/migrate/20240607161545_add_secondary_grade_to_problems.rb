class AddSecondaryGradeToProblems < ActiveRecord::Migration[7.1]
  def change
    add_column :problems, :secondary_grade, :string, null: true
  end
end
