# frozen_string_literal: true

class CreateNiveis < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:niveis)
      create_table :niveis do |t|
        t.string :descricao
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :niveis if table_exists?(:niveis)
  end
end
