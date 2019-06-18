class CreateApps < ActiveRecord::Migration[5.2]
  def change
    create_table :apps do |t|
      t.string :name
      t.string :key
      t.string :secret
      t.boolean :wired, default: false
      t.belongs_to :user
      
      t.belongs_to :created_by, references: :users
      t.belongs_to :updated_by, references: :users
      t.belongs_to :from_app, references: :apps
      t.timestamps null: false
    end
  end
end
