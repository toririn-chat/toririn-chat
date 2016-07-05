class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :room
      t.references :user
      t.text :content, null:false
      t.timestamps
    end
  end
end
