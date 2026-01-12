class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :identifier

      t.timestamps
    end
    add_index :users, :identifier
  end
end
