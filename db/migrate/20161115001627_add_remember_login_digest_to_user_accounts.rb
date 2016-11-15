class AddRememberLoginDigestToUserAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :user_accounts, :remember_login_digest, :string
  end
end
