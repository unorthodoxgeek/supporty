class AddMetaToSupportAndSenderIdToMessages < ActiveRecord::Migration
  def change
    #meta fields are meant to store customized data
    add_column :supports, :meta_fields, :text
    add_column :supports, :status, :string
    add_column :supports, :agent_id, :integer
    add_column :supports, :rating, :integer
    add_column :support_messages, :agent, :boolean, :default => false

    add_index :supports, [:status, :agent_id]
    add_index :supports, [:agent_id, :rating]
    #we want to bring in all messages regarding a ticket, in descending order
    #this index will make it a random access operation
    add_index :support_messages, [:support_id, :id]
  end
end
