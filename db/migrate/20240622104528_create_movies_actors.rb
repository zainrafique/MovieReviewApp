class CreateMoviesActors < ActiveRecord::Migration[7.1]
  def change
    create_table :movies_actors do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :actor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
