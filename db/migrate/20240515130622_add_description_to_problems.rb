class AddDescriptionToProblems < ActiveRecord::Migration[7.1]
  def change
    add_column :problems, :description, :text
  end
end
