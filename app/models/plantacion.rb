class Plantacion < ActiveRecord::Base
  belongs_to :tipo_plantacion
  belongs_to :estado_plantacion
  belongs_to :fuente_informacion
  belongs_to :fuente_imagen
  belongs_to :zona
  belongs_to :departamento
  belongs_to :estrato_desarrollo
  belongs_to :uso_forestal
  belongs_to :uso_anterior
  belongs_to :objetivo_plantacion
  belongs_to :error
  has_and_belongs_to_many :especies
end