class AddSubscribersCounterCacheToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :subscribers_count, :integer, :default => 0, :null => false
    add_index :locations, :subscribers_count
  end
end
