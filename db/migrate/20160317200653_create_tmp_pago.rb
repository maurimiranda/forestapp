class CreateTmpPago < ActiveRecord::Migration
  def change
    create_table :tmp_pagos do |t|
      t.string :resolucion
      t.string :anio_resolucion
      t.string :fecha_resolucion
      t.string :listado
      t.string :provincia
      t.string :zona
      t.string :numero_interno
      t.string :anio_plan
      t.string :numero_expediente
      t.string :numero_productor
      t.string :titular
      t.string :entidad
      t.string :anticipo
      t.string :forestacion
      t.string :poda
      t.string :raleo
      t.string :manejo
      t.string :enriquecimiento
      t.string :monto_aprobado
      t.string :superficie_forestacion
      t.string :superficie_poda
      t.string :superficie_raleo
      t.string :superficie_manejo
      t.string :superficie_enriquecimiento
      t.string :tipo
      t.string :titular_corregido_1
      t.string :dni_1
      t.string :cuit_1
      t.string :titular_corregido_2
      t.string :dni_2
      t.string :cuit_2
      t.string :titular_corregido_3
      t.string :dni_3
      t.string :cuit_3
      t.string :titular_corregido_4
      t.string :dni_4
      t.string :cuit_4
      t.string :titular_corregido_5
      t.string :dni_5
      t.string :cuit_5
      t.string :titular_corregido_6
      t.string :dni_6
      t.string :cuit_6
      t.index :numero_interno
      t.index :numero_expediente
      t.index :numero_productor
      t.index :titular
      t.index :entidad
      t.index :titular_corregido_1
      t.index :dni_1
      t.index :cuit_1
      t.index :titular_corregido_2
      t.index :dni_2
      t.index :cuit_2
      t.index :titular_corregido_3
      t.index :dni_3
      t.index :cuit_3
      t.index :titular_corregido_4
      t.index :dni_4
      t.index :cuit_4
      t.index :titular_corregido_5
      t.index :dni_5
      t.index :cuit_5
      t.index :titular_corregido_6
      t.index :dni_6
      t.index :cuit_6
    end
  end
end