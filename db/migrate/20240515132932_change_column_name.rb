class ChangeColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :problems, :description, :description_en
  end
end
