class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :content
      t.belongs_to :location, index: true
      t.timestamps
    end
  end
end
