class RemoveArchiveIdFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :archive_id
  end
end
