class AddColumnsToFootprints < ActiveRecord::Migration[7.0]
  def change
    add_column :footprints, :gaz, :integer
    add_column :footprints, :fioul, :integer
    add_column :footprints, :essence, :integer
    add_column :footprints, :gazole, :integer
    add_column :footprints, :electricite, :integer
    add_column :footprints, :clients_fr, :integer
    add_column :footprints, :clients_int, :integer
    add_column :footprints, :fournisseurs, :integer
    add_column :footprints, :taille_batiments, :integer
  end
end
