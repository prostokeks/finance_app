class AddWorkgroupToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :workgroup, :string, default: "user", null: false
  end
end
