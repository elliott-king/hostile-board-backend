class RemoveResumeFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :resume, :text # include type so it is reversible
  end
end
