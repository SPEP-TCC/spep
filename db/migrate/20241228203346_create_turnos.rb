class CreateTurnos < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:turnos)
      create_table :turnos do |t|
        t.string :descricao
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at

        t.timestamps
      end
    end
  end

  def down
    drop_table :turnos if table_exists?(:turnos)
  end
end
