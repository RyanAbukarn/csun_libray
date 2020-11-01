class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :phone
      t.string :address
      t.string :city
      t.string :state
      t.string :password_digest

      t.timestamps
    end
  end
end
