class CreateCursos < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:cursos)
      create_table :cursos do |t|
        t.string :descricao
        t.references :etapa, null: false, foreign_key: true
        t.references :curriculo_ementa, null: false, foreign_key: true
        t.references :instituicao, null: false, foreign_key: true
        t.references :modalidade, null: false, foreign_key: true
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at

        t.timestamps
      end
    end
  end
  def down
    drop_table :cursos if table_exists?(:cursos)
  end
end
