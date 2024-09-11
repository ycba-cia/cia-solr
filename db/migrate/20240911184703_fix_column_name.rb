class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :uuid, :uid
  end
end
