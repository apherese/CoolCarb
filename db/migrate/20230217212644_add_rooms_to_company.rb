class AddRoomsToCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :room_nb, :float, default: 0, null: false
  end
end
