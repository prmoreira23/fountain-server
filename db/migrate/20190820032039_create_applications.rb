class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.references :user, foreign_key: true
      t.references :job_opening, foreign_key: true

      t.timestamps
    end
  end
end
