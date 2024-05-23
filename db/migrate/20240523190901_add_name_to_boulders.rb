class AddNameToBoulders < ActiveRecord::Migration[7.1]
  def change
    add_column :boulders, :name, :string
  end
end
