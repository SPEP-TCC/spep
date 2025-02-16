class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :grades_curriculares
  has_many :restricoes
  has_many :turnos, through: :restricoes
  belongs_to :tipo_contrato

  accepts_nested_attributes_for :restricoes, allow_destroy: true

  def to_s
    self.nome
  end
end
