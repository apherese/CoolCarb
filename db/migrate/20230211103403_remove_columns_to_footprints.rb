class RemoveColumnsToFootprints < ActiveRecord::Migration[7.0]
  def change
    remove_column :footprints, :step, :string
    remove_column :footprints, :target_commitment, :integer
  end
end
