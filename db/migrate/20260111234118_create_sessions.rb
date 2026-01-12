class CreateSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :routine, null: false, foreign_key: true
      t.datetime :completed_at

      t.timestamps
    end
  end
end
