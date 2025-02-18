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

  validate :validar_cpf
  validates :cpf, uniqueness: { message: "já está em uso" }

  def to_s
    self.nome
  end

  private

  def validar_cpf
    if !CPF.valid?(cpf) 
      errors.add(:cpf, "é inválido!")
    end
  end
end
