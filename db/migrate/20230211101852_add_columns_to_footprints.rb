class AddColumnsToFootprints < ActiveRecord::Migration[7.0]
  def change
    add_column :footprints, :gaz, :integer, default: 0, null: false
    add_column :footprints, :fioul, :integer, default: 0, null: false
    add_column :footprints, :essence, :integer, default: 0, null: false
    add_column :footprints, :gazole, :integer, default: 0, null: false
    add_column :footprints, :electricite, :integer, default: 0, null: false
    add_column :footprints, :clients_fr, :integer, default: 0, null: false
    add_column :footprints, :clients_int, :integer, default: 0, null: false
    add_column :footprints, :fournisseurs, :integer, default: 0, null: false
    add_column :footprints, :taille_batiments, :integer, default: 0, null: false
  end
end
