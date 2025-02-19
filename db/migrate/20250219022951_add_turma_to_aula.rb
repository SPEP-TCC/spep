# frozen_string_literal: true

class AddTurmaToAula < ActiveRecord::Migration[7.2]
  def up
    add_reference :aulas, :turma, foreign_key: true unless column_exists?(:aulas, :turma_id)
  end

  def down
    remove_reference :aulas, :turma if column_exists?(:aulas, :turma_id)
  end
end
