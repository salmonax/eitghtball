class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.column :address

      t.timestamps
    end
  end
end
