class InitSchema < ActiveRecord::Migration[5.1]

  def change

    create_table :messages do |t|
      t.references :room, foreign_key: true, null: false
      t.references :person, foreign_key: true, null: false
      t.references :text, foreign_key: true
      t.references :stamp, foreign_key: true
      t.timestamps
    end

    create_table :rooms do |t|
      t.string :title, null: false
      t.timestamps
    end
    add_index :rooms, :title

    create_table :people do |t|
      t.string :name, null: false
      t.references :avater, foreign_key: true, null: false
      t.timestamps
    end
    add_index :people, :name

    create_table :avatars do |t|
      t.string :slug, null: false
      t.string :title, null: false, default: ''
      t.text :description, null: false, default: ''
      t.string :image, null: false
      t.references :avatar_group, foreign_key: true, null: false
      t.timestamps
    end
    add_index :avatars, :slug
    add_index :avatars, :title
    add_index :avatars, :description
    add_index :avatars, :image

    create_table :avatar_groups do |t|
      t.string :slug, null: false
      t.string :title, null: false
      t.text :description, null: false, default: ''
    end
    add_index :avatar_groups, :slug, unique: true
    add_index :avatar_groups, :title, unique: true
    add_index :avatar_groups, :description

    create_table :texts do |t|
      t.text :text, null: false
      t.timestamps
    end

    create_table :stamps do |t|
      t.string :slug, null: false
      t.string :title, null: false, default: ''
      t.text :description, null: false, default: ''
      t.string :image, null: false
      t.references :stamp_group, foreign_key: true, null: false
      t.timestamps
    end
    add_index :stamps, :slug
    add_index :stamps, :title
    add_index :stamps, :description
    add_index :stamps, :image

    create_table :stamp_groups do |t|
      t.string :slug, null: false
      t.string :title, null: false
      t.text :description, null: false, default: ''
    end
    add_index :stamp_groups, :slug, unique: true
    add_index :stamp_groups, :title, unique: true
    add_index :stamp_groups, :description

    create_table :users do |t|
      # Database authenticatable
      t.string :name, null:false
      t.string :organization, null:false
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      # Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      # Rememberable
      t.datetime :remember_created_at
      # Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      # Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable
      # Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at
      # Timestamps
      t.timestamps null: false
    end
    add_index :users, :name
    add_index :users, :organization
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
