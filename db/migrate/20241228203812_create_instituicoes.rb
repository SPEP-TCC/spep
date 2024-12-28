class CreateInstituicoes < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:instituicoes)
      create_table :instituicoes do |t|
        t.string :nome
        t.integer :duracao_aula
        t.integer :tempos_dia
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at

        t.timestamps
      end
    end
  end

  def down
    drop_table :instituicoes if table_exists?(:instituicoes)
  end
end
