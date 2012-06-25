class CreateSupportMessages < ActiveRecord::Migration
  def change
    create_table :support_messages do |t|
      t.integer :support_id
      t.text :body
      t.string :subject
      t.string :from_email
      t.string :from_name
      t.timestamps
    end
  end
end
