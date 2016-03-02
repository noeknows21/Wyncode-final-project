class AddRepCodeToUser < ActiveRecord::Migration
  def change
    add_column :users, :repcode, :string
  end
end
