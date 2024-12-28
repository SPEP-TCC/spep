class CreateSubareas < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:subareas)
      create_table :subareas do |t|
        t.string :descricao
        t.references :area, null: true, foreign_key: true
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at

        t.timestamps
      end
    end
  end
  def down
    drop_table :subareas if table_exists?(:subareas)
  end
end
