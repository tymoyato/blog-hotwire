class CreateTagged < ActiveRecord::Migration[7.1]
  def change
    create_table :taggeds do |t|
      t.references :post, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
