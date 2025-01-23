class Subarea < ApplicationRecord
  belongs_to :area
  has_many :disciplinas
end
