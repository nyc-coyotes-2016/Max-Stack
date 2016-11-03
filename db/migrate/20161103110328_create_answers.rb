class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :text, null: false
      t.integer :question_id, null: false
      t.integer :responder_id, null: false
      t.boolean :best_answer, default: false

      t.timestamps(null: false)
    end
  end
end
