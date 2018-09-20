class InitSchema < ActiveRecord::Migration[5.1]

  def change

    create_table :messages do |t|
      t.references :room, foreign_key: true, null: false
      t.references :person, foreign_key: true, null: false
      t.text :text
      t.references :sticker, foreign_key: true
      t.timestamps
    end

    create_table :rooms do |t|
      t.string :name, null: false
      t.datetime :begin_at
      t.datetime :end_at
      t.string :token, null: false
      t.string :code
      t.boolean :active, null: false, default: false
      t.timestamps
    end
    add_index :rooms, :name
    add_index :rooms, :begin_at
    add_index :rooms, :end_at
    add_index :rooms, :token, unique: true
    add_index :rooms, :code
    add_index :rooms, :active

    create_table :people do |t|
      t.string :name, null: false
      t.references :avatar, foreign_key: true, null: false
      t.timestamps
    end
    add_index :people, :name

    create_table :avatars do |t|
      t.string :image, null: false
      t.references :avatar_group, foreign_key: true, null: false
      t.timestamps
    end

    create_table :avatar_groups do |t|
      t.string :title
      t.string :author
      t.text :url
      t.string :license_name
      t.text :license_url
    end
    add_index :avatar_groups, :title
    add_index :avatar_groups, :author
    add_index :avatar_groups, :url
    add_index :avatar_groups, :license_name
    add_index :avatar_groups, :license_url

    create_table :stickers do |t|
      t.string :image, null: false
      t.references :sticker_group, foreign_key: true, null: false
      t.timestamps
    end

    create_table :sticker_groups do |t|
      t.string :title
      t.string :author
      t.text :url
      t.string :license_name
      t.text :license_url
    end
    add_index :sticker_groups, :title
    add_index :sticker_groups, :author
    add_index :sticker_groups, :url
    add_index :sticker_groups, :license_name
    add_index :sticker_groups, :license_url

    # create_table :authorizations do |t|
    #   t.references :room, foreign_key: true, null: false
    #   t.integer :count, default: 0, null: false
    #   t.datetime :begin_at
    #   t.datetime :end_at
    #   t.string :token
    # end

    create_table :users do |t|
      # User information
      t.string :person_name, null: false, default: ''
      t.string :organization_name, null: false, default: ''
      # Database authenticatable
      t.string :email, null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      # Recoverable
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      # Rememberable
      t.datetime :remember_created_at
      # Trackable
      t.integer :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip
      # Confirmable
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unconfirmed_email # Only if using reconfirmable
      # Lockable
      t.integer :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at
      # Timestamps
      t.timestamps null: false
    end
    add_index :users, :person_name
    add_index :users, :organization_name
    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token, unique: true
    add_index :users, :unlock_token, unique: true

    create_table :user_rooms do |t|
      t.references :user, foreign_key: true, null: false
      t.references :room, foreign_key: true, null: false
      # role mamager, observer
    end

    create_table :person_messages do |t|
      t.references :person, foreign_key: true, null: false
      t.references :message, foreign_key: true, null: false
      t.boolean :like, null: false, default: false
      t.boolean :read, null: false, default: false
      t.timestamps
    end
    add_index :person_messages, [:person_id, :message_id], unique: true

  end
end
