class CreateRegisteredApps < ActiveRecord::Migration[5.2]
  def change
    create_table :registered_apps do |t|
      t.string :name
      t.string :api_token
      t.belongs_to :admin
      t.timestamps null: false
    end
  end
end
