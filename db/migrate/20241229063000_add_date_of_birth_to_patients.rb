class AddDateOfBirthToPatients < ActiveRecord::Migration[8.0]
  def change
    add_column :patients, :date_of_birth, :date
  end
end
