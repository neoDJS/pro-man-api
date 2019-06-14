class CreateWorkers < ActiveRecord::Migration[5.2]
  def change
    create_table :workers do |t|
      t.string :title
      t.belongs_to :user
      
      t.belongs_to :created_by, references: :users
      t.belongs_to :updated_by, references: :users
      t.belongs_to :from_app, references: :apps
      t.timestamps null: false
    end
  end
end
