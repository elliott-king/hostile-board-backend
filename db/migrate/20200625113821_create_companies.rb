class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :website
      t.string :company_logo
      t.timestamps
    end
  end
end
