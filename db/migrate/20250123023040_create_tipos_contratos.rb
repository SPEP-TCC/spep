# frozen_string_literal: true

class CreateTiposContratos < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:tipos_contratos)
      create_table :tipos_contratos do |t|
        t.string :descricao
        t.integer :carga_horaria
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :tipos_contratos if table_exists?(:tipos_contratos)
  end
end
