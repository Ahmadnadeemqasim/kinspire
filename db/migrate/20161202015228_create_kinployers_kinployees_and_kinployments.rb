class CreateKinployersKinployeesAndKinployments < ActiveRecord::Migration[5.0]
  def change
    create_table :kinployees do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end

    create_table :kinployers do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end

    create_table :kinployments do |t|
      t.references :kinployee
      t.references :kinployer

      t.timestamps
    end
  end
end
