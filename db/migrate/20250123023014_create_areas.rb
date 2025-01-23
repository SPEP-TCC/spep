# frozen_string_literal: true

class CreateAreas < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:areas)
      create_table :areas do |t|
        t.string :descricao
        t.references :etapa, foreign_key: true
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :areas if table_exists?(:areas)
  end
end
