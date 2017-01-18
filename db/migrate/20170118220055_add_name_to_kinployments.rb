class AddNameToKinployments < ActiveRecord::Migration[5.0]
  def change
    add_column :kinployments, :name, :string
  end
end
