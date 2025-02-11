# frozen_string_literal: true

class AddUserToAula < ActiveRecord::Migration[7.2]
  def up
    unless column_exists?(:aulas, :user_id)
      add_reference :aulas, :user, foreign_key: true, null: true
    end
  end

  def down
    if column_exists?(:aulas, :user_id)
      remove_reference :aulas, :user
    end
  end
end
