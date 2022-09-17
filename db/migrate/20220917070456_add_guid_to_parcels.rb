class AddGuidToParcels < ActiveRecord::Migration[6.1]
  def change
    add_column :parcels, :guid, :string, null: false, index: true
  end
end
