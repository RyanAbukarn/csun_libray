class AddIsCheckedOutToRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :is_checked_out, :boolean, default: false
  end
end
