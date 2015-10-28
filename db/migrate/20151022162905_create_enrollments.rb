class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      # This gets sent to PokitDok
      t.string :reference_number

      t.integer :account_id

      t.json :properties_data

      t.timestamp :created_at
      t.timestamp :updated_at
      t.timestamp :deleted_at
    end
  end
end
