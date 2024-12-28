class CreateMatrizesCurricularesAplicadas < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:matrizes_curriculares_aplicadas)
      create_table :matrizes_curriculares_aplicadas do |t|
        t.string :descricao
        t.integer :ano_letivo
        t.references :turno, null: false, foreign_key: true
        t.references :curso, null: false, foreign_key: true
        t.boolean :ativo
        t.string :created_by
        t.string :updated_by
        t.datetime :delete_at

        t.timestamps
      end
    end
  end
  def down
    drop_table :matrizes_curriculares_aplicadas if table_exists?(:matrizes_curriculares_aplicadas)
  end
end
