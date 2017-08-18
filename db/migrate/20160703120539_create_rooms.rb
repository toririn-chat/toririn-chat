class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :name, null:false
      t.integer :teacher_id, null:false, foreign_key:true
      t.timestamps
    end
  end
end
