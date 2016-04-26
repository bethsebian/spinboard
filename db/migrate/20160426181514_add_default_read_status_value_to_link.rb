class AddDefaultReadStatusValueToLink < ActiveRecord::Migration
  def change
    change_column :links, :read_status, :boolean, :default => false
  end
end
