class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content, {null: false}
      t.integer :commentable_id, {null: false}
      t.string :commentable_type, {null: false} #on schema as integer type
      t.integer :commenter_id, {null: false}

      t.timestamps(null: false)
    end
  end
end
