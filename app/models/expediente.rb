class Expediente < ActiveRecord::Base
  belongs_to :zona
  belongs_to :zona_departamento
  belongs_to :tecnico
  has_many :movimientos
  has_and_belongs_to_many :titulares

  validates :numero_interno, :numero_expediente, presence: true, uniqueness: true
  validates :numero_interno, format: { with: /[0-9]{2}-[0-9]{3}-[0-9]{3}\/[0-9]{2}/, message: "el formato debe ser ##-###-###/##" }
  validates :numero_expediente, format: { with: /EXP-S05:[0-9]{7}\/[0-9]{4}/, message: "el formato debe ser EXP-S05:#######/####" }, on: :create

  attr_reader :incompleto, :fecha_entrada_desde, :fecha_entrada_hasta, :fecha_salida_desde, :fecha_salida_hasta, :pendiente,
    :estabilidad_fiscal, :etapa, :responsable_id, :validado, :validador_id

  before_save :set_values

  ##
  # Define los valores de zona, departamento y anio a partir del número interno
  def set_values
    if numero_interno_changed?
      self.zona = Zona.find_by_codigo(numero_interno[0..1])
      self.zona_departamento = zona.zona_departamentos.find_by_codigo(numero_interno[3..5]) if zona
      self.anio = numero_interno[11..12].to_i < 80 ? numero_interno[11..12].to_i + 2000 : numero_interno[11..12].to_i + 1900
    end
  end

  def incompleto=(value)
    if !!value == value
      @incompleto = value
    elsif not value.blank?
      @incompleto = (value == "true")
    end
  end

  def pendiente=(value)
    if !!value == value
      @pendiente = value
    elsif not value.blank?
      @pendiente = (value == "true")
    end
  end

  def estabilidad_fiscal=(value)
    if !!value == value
      @estabilidad_fiscal = value
    elsif not value.blank?
      @estabilidad_fiscal = (value == "true")
    end
  end

  def validado=(value)
    if !!value == value
      @validado = value
    elsif not value.blank?
      @validado = (value == "true")
    end
  end

  def etapa=(value)
    @etapa = value unless value.blank?
  end

  def responsable_id=(value)
    @responsable_id = value unless value.blank?
  end

  def fecha_entrada_desde=(value)
    @fecha_entrada_desde = value unless value.blank?
  end

  def fecha_entrada_hasta=(value)
    @fecha_entrada_hasta = value unless value.blank?
  end

  def fecha_salida_desde=(value)
    @fecha_salida_desde = value unless value.blank?
  end

  def fecha_salida_hasta=(value)
    @fecha_salida_hasta = value unless value.blank?
  end

  def validador_id=(value)
    @validador_id = value unless value.blank?
  end

  ##
  # Devuelve la fecha de entrada del último movimiento del expediente
  def ultima_entrada
    movimientos.order(:fecha_entrada).last.fecha_entrada if movimientos.count > 0
  end

  ##
  # Devuelve la fecha de salida del último movimiento del expediente
  def ultima_salida
    movimientos.order(:fecha_salida).last.fecha_salida if movimientos.count > 0
  end

  ##
  # Devuelve el último movimiento del expediente
  def ultimo_movimiento
    movimientos.order(:fecha_salida).last if movimientos.count > 0
  end

  ##
  # Busca los expedientes que coincidan con los atributos definidos en el objeto Expdiente pasado como parámetro
  def self.search(expediente)
    expedientes = all
    if expediente
      expedientes = expedientes.where("numero_interno ILIKE ?", "%#{expediente.numero_interno}%") unless expediente.numero_interno.blank?
      expedientes = expedientes.where(zona_id: expediente.zona_id) unless expediente.zona_id.nil?
      expedientes = expedientes.where(tecnico_id: expediente.tecnico_id) unless expediente.tecnico_id.nil?
      expedientes = expedientes.where("numero_expediente ILIKE ?", "%#{expediente.numero_expediente}%") unless expediente.numero_expediente.blank?
      expedientes = expedientes.where("numero_expediente IS #{'NOT' unless expediente.incompleto} NULL") unless expediente.incompleto.nil?
      expedientes = expedientes.joins(:movimientos).where("movimientos.responsable_id = ?", expediente.responsable_id) unless expediente.responsable_id.nil?
      expedientes = expedientes.joins(:movimientos).where("expedientes.anio = ? OR movimientos.etapa = ?", expediente.etapa.to_i, expediente.etapa.to_i) unless expediente.etapa.nil?
      expedientes = expedientes.joins(:movimientos).where("movimientos.fecha_entrada >= ?", expediente.fecha_entrada_desde) unless expediente.fecha_entrada_desde.nil?
      expedientes = expedientes.joins(:movimientos).where("movimientos.fecha_entrada <= ?", expediente.fecha_entrada_hasta) unless expediente.fecha_entrada_hasta.nil?
      expedientes = expedientes.joins(:movimientos).where("movimientos.fecha_salida >= ?", expediente.fecha_salida_desde) unless expediente.fecha_salida_desde.nil?
      expedientes = expedientes.joins(:movimientos).where("movimientos.fecha_salida <= ?", expediente.fecha_salida_hasta) unless expediente.fecha_salida_hasta.nil?
      expedientes = expedientes.joins(:movimientos).where("movimientos.estabilidad_fiscal = ?", expediente.estabilidad_fiscal) unless expediente.estabilidad_fiscal.nil?
      expedientes = expedientes.joins(:movimientos).where("movimientos.validador_id IS #{'NOT' if expediente.validado} NULL") unless expediente.validado.nil?
      expedientes = expedientes.joins(:movimientos).where("movimientos.validador_id = ?", expediente.validador_id) unless expediente.validador_id.nil?
      expedientes = expedientes.where(plurianual: expediente.plurianual) unless expediente.plurianual.nil?
      expedientes = expedientes.where(agrupado: expediente.agrupado) unless expediente.agrupado.nil?
      expedientes = expedientes.where(activo: expediente.activo) unless expediente.activo.nil?
      expedientes = expedientes.joins(:movimientos).where("movimientos.fecha_salida IS #{'NOT' unless expediente.pendiente} NULL") unless expediente.pendiente.nil?
      expedientes = expedientes.distinct
    end
    expedientes
  end
end
