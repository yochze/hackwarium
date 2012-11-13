class CreateFacts < ActiveRecord::Migration
  def change
    create_table :facts do |t|
      t.text :content
      t.integer :user_id
      t.text :source

      t.timestamps
    end
  end
end
