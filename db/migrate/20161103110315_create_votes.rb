class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :vote_value, {null: false}
      t.integer :votable_id, {null: false}
      t.string :votable_type, {null: false} #on schema as integer type
      t.integer :voter_id, {null: false} #Uniqueness with scope to a user & votable item

      t.timestamps(null: false)
    end
  end
end
