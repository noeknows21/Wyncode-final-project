class AddStuffToUser < ActiveRecord::Migration
  def change
    add_column :users, :session_id, :string
    add_column :users, :allow_join, :true
  end
end
