class Tecnico < ActiveRecord::Base
  has_many :expedientes

  def self.search(tecnico)
    tecnicos = all
    if tecnico
      tecnicos = where("nombre ILIKE ?", "%#{tecnico.nombre}%") unless tecnico.nombre.blank?
      tecnicos = tecnicos.where(activo: tecnico.activo) unless tecnico.activo.nil?
      tecnicos = tecnicos.distinct
    end
    tecnicos.order(:nombre)
  end
end