class CreateAulas < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:aulas)
      create_table :aulas do |t|
        t.references :grade_curricular, null: false, foreign_key: true
        t.references :ambiente, null: false, foreign_key: true
        t.integer :dia
        t.time :horario_inicio
        t.time :horario_fim
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at

        t.timestamps
      end
    end
  end

  def down
    drop_table :aulas if table_exists?(:aulas)
  end
end
