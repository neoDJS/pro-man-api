class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.string :api_token
      t.belongs_to :user
      t.belongs_to :app

      t.timestamps
    end
  end
end
