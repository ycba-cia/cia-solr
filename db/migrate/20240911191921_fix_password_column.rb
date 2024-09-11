  class FixPasswordColumn < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :encrypted_password, true
  end
end
