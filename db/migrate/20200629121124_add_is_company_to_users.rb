class AddIsCompanyToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_company, :boolean, default: false
  end
end
