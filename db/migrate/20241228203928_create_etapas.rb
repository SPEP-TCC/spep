class CreateEtapas < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:etapas)
      create_table :etapas do |t|
        t.string :descricao
        t.references :nivel, null: false, foreign_key: true
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at

        t.timestamps
      end
    end
  end
  def down
    drop_table :etapas if table_exists?(:etapas)
  end
end
