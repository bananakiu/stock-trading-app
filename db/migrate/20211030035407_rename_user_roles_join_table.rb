class RenameUserRolesJoinTable < ActiveRecord::Migration[6.1]
  def change
    rename_table :users_roles, :roles_users
  end
end
