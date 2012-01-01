class CreateSupports < ActiveRecord::Migration
  def change
    create_table :supports do |t|
    	t.string :reason
    	t.integer :user_id
    	t.string :name
    	t.string :email
    	t.text :support
      t.timestamps
    end
  end
end
