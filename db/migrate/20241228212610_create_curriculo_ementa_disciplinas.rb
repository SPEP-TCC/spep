class CreateCurriculoEmentaDisciplinas < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:curriculo_ementa_disciplinas)
      create_table :curriculo_ementa_disciplinas do |t|
        t.references :curriculo_ementa, null: false, foreign_key: true
        t.references :disciplina, null: false, foreign_key: true
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at

        t.timestamps
      end
    end
  end
  def down
    drop_table :curriculo_ementa_disciplinas if table_exists?(:curriculo_ementa_disciplinas)
  end
end
