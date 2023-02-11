class RemoveKwhFromCompanies < ActiveRecord::Migration[7.0]
  def change
    remove_column :companies, :kwh
  end
end
