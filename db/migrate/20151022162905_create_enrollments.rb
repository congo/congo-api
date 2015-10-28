class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      # This Reference ID gets sent to PokitDok
      t.string :reference_number
      t.index :reference_number

      t.integer :account_id

      t.json :properties_data

      t.timestamp :created_at
      t.timestamp :updated_at
      t.timestamp :deleted_at
      t.index :deleted_at
    end
  end
end
