class AddPositionToMessage < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :position, null: false, foreign_key: true
  end
end
