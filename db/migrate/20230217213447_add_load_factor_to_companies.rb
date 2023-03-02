class AddLoadFactorToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :load_factor, :float, default: 70, null: false
  end
end
