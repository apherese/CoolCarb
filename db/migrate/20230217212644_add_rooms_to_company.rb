class AddRoomsToCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :room_nb, :integer, default: 100, null: false
  end
end
