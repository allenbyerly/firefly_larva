class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :pname
      t.string :location
      t.string :price
      t.string :copay

      t.timestamps
    end
  end
end
