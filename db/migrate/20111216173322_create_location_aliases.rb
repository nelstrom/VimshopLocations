class CreateLocationAliases < ActiveRecord::Migration
  def change
    create_table :location_aliases do |t|
      t.string :city
      t.string :country
      t.references :location

      t.timestamps
    end

    add_index [:city, :country]
  end
end
