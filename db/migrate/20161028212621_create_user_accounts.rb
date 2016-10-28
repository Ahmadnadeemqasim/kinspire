class CreateUserAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :user_accounts do |t|
      t.string :email

      t.timestamps
    end
    add_index :user_accounts, :email, unique: true
  end
end
