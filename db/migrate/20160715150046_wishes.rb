class Wishes < ActiveRecord::Migration
  def change
    create_table :wishes do |t|
    	t.integer :user_id
      t.text :user_name
      t.text :wish
      t.datetime :date
    end
  end
end
