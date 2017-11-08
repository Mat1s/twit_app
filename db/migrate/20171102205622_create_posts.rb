class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :body
      t.string :image
      t.string :link_to_twitter
      t.references :user
      t.timestamps
    end
  end
end
