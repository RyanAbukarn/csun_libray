class AddIsCheckedInToRegistration < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :is_checked_in, :boolean, default: false
  end
end
