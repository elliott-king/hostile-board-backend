class AddApplicationColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :applications, :skills, :string, array: true
    add_column :applications, :job_history, :text
    add_column :applications, :projects, :text 
    add_column :applications, :written_introduction, :text
  end
end
