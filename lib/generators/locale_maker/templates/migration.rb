class CreateLocales < ActiveRecord::Migration
  def self.up
    create_table :locales do |t|
      t.column :name, :string
      t.column :translation, :string
      t.column :original, :integer
      t.column :locale_code, :string
      t.column :required_fields, :string
      t.column :info, :text
      t.column :page, :string
      t.column :order, :integer, :default=>999
      t.column :done, :boolean, :default=>false
      t.column :admin, :boolean, :default=>false
      t.timestamps
    end
  end

  def self.down
    drop_table :locales
  end
end
