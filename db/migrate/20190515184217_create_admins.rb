class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :email
      t.boolean :admin, default: true
      t.string :password_digest
      t.timestamps null: false
    end
  end
end
