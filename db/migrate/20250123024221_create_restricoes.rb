# frozen_string_literal: true

class CreateRestricoes < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:restricoes)
      create_table :restricoes do |t|
        t.references :user, foreign_key: true
        t.references :turno, foreign_key: true
        t.integer :dia
        t.string :horario
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :restricoes if table_exists?(:restricoes)
  end
end
