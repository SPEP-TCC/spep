class AddTipoContratoToUser < ActiveRecord::Migration[7.2]
  def up
    unless column_exists?(:users, :tipo_contrato_id)
      add_reference :users, :tipo_contrato, foreign_key: true
    end
  end

  def down
    if column_exists?(:users, :tipo_contrato_id)
      remove_reference :users, :tipo_contrato
    end
  end
end
