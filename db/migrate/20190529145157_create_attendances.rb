class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.integer :user
      t.integer :event
    end
    add_index :attendances, :user
    add_index :attendances, :event
  end
end
