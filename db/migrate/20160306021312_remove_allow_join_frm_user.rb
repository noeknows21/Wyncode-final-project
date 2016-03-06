class RemoveAllowJoinFrmUser < ActiveRecord::Migration
  def change
    remove_column :users, :allow_join
  end
end
