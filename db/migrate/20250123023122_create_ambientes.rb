# frozen_string_literal: true

class CreateAmbientes < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:ambientes)
      create_table :ambientes do |t|
        t.string :descricao
        t.integer :capacidade
        t.boolean :periculosidade
        t.references :instituicao, foreign_key: true
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :ambientes if table_exists?(:ambientes)
  end
end
