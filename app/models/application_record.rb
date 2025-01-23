class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class


  def self.ransackable_attributes(auth_object = nil)
    column_names + _ransackers.keys
  end

  def self.ransackable_associations(auth_object = nil)
    reflect_on_all_associations.map do |assoc|
      assoc.name.to_s
    end
  end

  private

  def set_destroyed
    if self.has_attribute?(:updated_by)
      self.updated_by = Current.user&.cpf
      save(validate: false)
    end
  end

  def set_updated_by
    if self.has_attribute?(:updated_by)
      self.updated_by = Current.user&.cpf
    end
  end

  def set_created_by
    if self.has_attribute?(:created_by)
      self.created_by = Current.user&.cpf
    end
  end

  def string_to_decimal(valor)
    valor = valor.gsub(/[.,]/, "")
    valor = valor.to_f / 100
  end
end
