class AddCheckInAndOutToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :check_in, :datetime
    add_column :registrations, :check_out, :datetime
  end
end
