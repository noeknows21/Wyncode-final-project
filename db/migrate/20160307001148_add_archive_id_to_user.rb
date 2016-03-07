class AddArchiveIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :archive_id, :string
  end
end
