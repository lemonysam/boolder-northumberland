class MakeBleauIdOptional < ActiveRecord::Migration[7.1]
  def change
    change_column_null :areas, :bleau_area_id, true
  end
end
