class CreatePositions < ActiveRecord::Migration[6.0]
  def change
    create_table :positions do |t|
      t.string :title
      t.string :city
      t.string :description
      t.string :company_id

      t.timestamps
    end
  end
end
