class ChangeVersionColumnsType < ActiveRecord::Migration[6.0]
  def change
    change_column :licenses, :max_version, :string
    change_column :licenses, :min_version, :string
  end
end
