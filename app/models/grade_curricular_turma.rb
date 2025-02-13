# frozen_string_literal: true

class GradeCurricularTurma < ApplicationRecord
  belongs_to :turma
  belongs_to :grade_curricular
end
