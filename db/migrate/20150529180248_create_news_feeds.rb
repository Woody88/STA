class CreateNewsFeeds < ActiveRecord::Migration
  def change
    create_table :news_feeds do |t|
      t.string :title
      t.text :body
      t.references :profile, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
