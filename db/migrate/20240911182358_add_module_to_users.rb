class AddModuleToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :module, :string
  end
end
