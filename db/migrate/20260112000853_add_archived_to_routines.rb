class AddArchivedToRoutines < ActiveRecord::Migration[8.0]
  def change
    add_column :routines, :archived, :boolean
  end
end
