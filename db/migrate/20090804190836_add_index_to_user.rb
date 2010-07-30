class AddIndexToUser < ActiveRecord::Migration
  def self.up
    add_index :users, :last_request_at
  end

  def self.down
    drop_table :users
  end
end
