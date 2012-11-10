class CreateImpressions < ActiveRecord::Migration
  def change
    create_table :impressions do |t|
      t.integer :post_id
      t.integer :user_id
      t.string :ip_address
      t.string :useragent
      t.string :referrer

      t.timestamps
    end
  end
end
