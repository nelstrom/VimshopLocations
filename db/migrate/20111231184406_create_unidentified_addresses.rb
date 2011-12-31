class CreateUnidentifiedAddresses < ActiveRecord::Migration
  def change
    create_table :unidentified_addresses do |t|
      t.string :original
      t.string :correction

      t.timestamps
    end
  end
end
