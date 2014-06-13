class CreateMessages < ActiveRecord::Migration

  def up
    create_table :refinery_messages do |t|
      t.string :name
      t.text :message

      t.timestamps
    end

    add_index :refinery_messages, :id
  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "messages"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/messages"})
    end

    drop_table :refinery_messages
  end

end
