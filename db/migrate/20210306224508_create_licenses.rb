class CreateLicenses < ActiveRecord::Migration[6.0]
  def change
    create_table :licenses do |t|
      t.date :paid_till, null: false
      t.date :max_version, null: true
      t.date :min_version, null: true

      t.timestamps
    end
  end
end
