class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :image
      t.string :provider
      t.string :uid

      t.timestamps
    end

    add_index :users, [:provider, :uid]
  end
end
