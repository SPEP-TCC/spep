# frozen_string_literal: true

class CreateDisciplinas < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:disciplinas)
      create_table :disciplinas do |t|
        t.string :descricao
        t.string :codigo
        t.references :area, null: true, foreign_key: true
        t.references :subarea, null: true, foreign_key: true
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :disciplinas if table_exists?(:disciplinas)
  end
end
