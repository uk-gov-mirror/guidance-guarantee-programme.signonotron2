class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.text :certificate
      t.text :key_handle
      t.text :public_key
      t.integer :counter

      t.timestamps
    end
  end
end
