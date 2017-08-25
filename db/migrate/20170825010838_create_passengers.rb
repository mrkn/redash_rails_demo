class CreatePassengers < ActiveRecord::Migration[5.1]
  def change
    create_table :passengers do |t|
      t.integer :survived
      t.integer :pclass
      t.string :name
      t.string :sex
      t.integer :age
      t.integer :sibsp
      t.integer :parch
      t.string :ticket
      t.float :fare
      t.string :cabin
      t.string :embarked
    end
  end
end
