class CreateUserMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :user_messages do |t|
      t.references :user
      t.references :message
      t.boolean :read, null: false, default: true
      t.timestamps
    end
  end
end
