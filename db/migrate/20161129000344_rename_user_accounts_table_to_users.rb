class RenameUserAccountsTableToUsers < ActiveRecord::Migration[5.0]
  def change
    rename_table :user_accounts, :users
  end
end
