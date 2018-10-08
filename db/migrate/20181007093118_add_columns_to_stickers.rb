class AddColumnsToStickers < ActiveRecord::Migration[5.2]
  def change
    #
    # stickers
    #
    # add name and index
    add_column :stickers, :name, :string
    add_index :stickers, :name
    # add content_data
    add_column :stickers, :content_data, :binary, limit: 10.megabyte
    change_column :stickers, :content_data, :binary, limit: 10.megabyte, null: false
    # add content_type
    add_column :stickers, :content_type, :string
    change_column :stickers, :content_type, :string, null: false
    # remove image
    remove_column :stickers, :image
    #
    # sticker_groups
    #
    # remove title and index
    remove_index :sticker_groups, :title
    remove_column :sticker_groups, :title
    # add name and index
    add_column :sticker_groups, :name, :string
    add_index :sticker_groups, :name
  end
end
