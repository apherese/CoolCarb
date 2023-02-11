class AddColumnsScopeToFootprint < ActiveRecord::Migration[7.0]
  def change
    add_column :footprints, :scope_1, :float, default: 0, null: false
    add_column :footprints, :scope_2, :float, default: 0, null: false
    add_column :footprints, :scope_3, :float, default: 0, null: false
    remove_column :footprints, :ghg_result
    add_column :footprints, :ghg_result, :float
  end
end
