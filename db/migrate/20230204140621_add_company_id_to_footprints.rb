class AddCompanyIdToFootprints < ActiveRecord::Migration[7.0]
  def change
    add_reference :footprints, :company, foreign_key: true
  end
end
