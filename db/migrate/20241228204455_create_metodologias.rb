class CreateMetodologias < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:metodologias)
      create_table :metodologias do |t|
        t.string :descricao
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at

        t.timestamps
      end
    end
  end

  def down
    drop_table :metodologias if table_exists?(:metodologias)
  end
end
