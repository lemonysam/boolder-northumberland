class AddGradeRefToProblems < ActiveRecord::Migration[7.1]
  def change
    add_reference :problems, :grade, foreign_key: true
  end
end
