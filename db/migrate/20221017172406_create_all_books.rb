class CreateAllBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :all_books do |t|
      t.string :name
      t.float :stars
      t.string :image
      t.string :link
      t.integer :total_reviews
      t.boolean :best_seller
      t.boolean :current_reading
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
