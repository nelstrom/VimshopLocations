class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :email, :null => false
      t.string :first_name
      t.string :last_name
      t.references :location

      t.timestamps
    end

    add_index :subscribers, :email
  end
end
