class InteresBasico < ActiveRecord::Base
	belongs_to :prospecto
	belongs_to :ultimo_grado_de_estudio
	belongs_to :preparatoria_o_universidad_de_origen
	belongs_to :municipio_de_la_preparatoria_o_universidad_de_origen
	belongs_to :sede
	belongs_to :programa_de_intere
	belongs_to :nivel
	belongs_to :turno
	belongs_to :periodo_para_ingresar
	belongs_to :status_de_interes_de_prospecto_validado
	belongs_to :subsede
	belongs_to :programa
	belongs_to :modalidad
end
