class CreatePrototypeTags < ActiveRecord::Migration
  def change
    create_table :prototype_tags do |t|
      t.references :prototype, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps null: false
    end
  end
end
