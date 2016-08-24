class CreateUserMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :user_messages do |t|
      t.references :user, foreign_key: true
      t.references :message, foreign_key: true
      t.boolean :read, null: false, default: true
      t.timestamps
    end
  end
end
