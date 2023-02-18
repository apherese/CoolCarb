class SquareMeterFromCompanies < ActiveRecord::Migration[7.0]
  def change
    remove_column :companies, :square_meter
  end
end
