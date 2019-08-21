class CreateJobOpenings < ActiveRecord::Migration[5.2]
  def change
    create_table :job_openings do |t|
      t.string :title
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
