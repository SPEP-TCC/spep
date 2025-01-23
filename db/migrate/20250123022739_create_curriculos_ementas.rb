# frozen_string_literal: true

class CreateCurriculosEmentas < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:curriculos_ementas)
      create_table :curriculos_ementas do |t|
        t.string :descricao
        t.integer :ano_documento
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :curriculos_ementas if table_exists?(:curriculos_ementas)
  end
end
