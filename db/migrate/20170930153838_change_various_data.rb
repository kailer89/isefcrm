class ChangeVariousData < ActiveRecord::Migration
  def up

  	ultimoGradoDeEstudiox = UltimoGradoDeEstudio.where(:grado_de_estudio=>"sin información").first.id
  	municipioDeLaPreparatoriaOUniversidadDeOrigenx = MunicipioDeLaPreparatoriaOUniversidadDeOrigen.where(:valor=>"sin información").first.id
  	statusDeInteresDeProspectoValidadox = StatusDeInteresDeProspectoValidado.where(:valor=>"Por confirmar su interés").first.id

  	InteresBasico.find_each do |record|
  		if record.ultimo_grado_de_estudios == nil
  			record.ultimo_grado_de_estudios = ultimoGradoDeEstudiox
  		end
  		if record.municipio_de_la_preparatoria_universidad_de_origen == nil
  			record.municipio_de_la_preparatoria_universidad_de_origen = municipioDeLaPreparatoriaOUniversidadDeOrigenx
  		end 
  		if record.status_de_interes_del_prospecto_validado == nil
  			record.status_de_interes_del_prospecto_validado = statusDeInteresDeProspectoValidadox
  		end 
  		if record.periodo_para_ingresar == nil
  			#obtain the month when the record was created as well as the year, find the record that it corresponds to
  			anio = record.created_at.year - 2000
  			mes = record.created_at.month

  			backup = "N/A"

  			actualMes = ""
			case mes # a_variable is the variable we want to compare
			when 1    #compare to 1
			  actualMes = "ene"
			when 2    #compare to 2
			  actualMes = "feb"
			when 3    #compare to 2
			  actualMes = "mar"
			when 4    #compare to 2
			  actualMes = "abr"	
			when 5    #compare to 2
			  actualMes = "may"
			when 6    #compare to 2
			  actualMes = "jun"
			when 7    #compare to 2
			  actualMes = "jul"
			when 8    #compare to 2
			  actualMes = "ago"
			when 9    #compare to 2
			  actualMes = "sep"
			when 10    #compare to 2
			  actualMes = "oct"
			when 11    #compare to 2
			  actualMes = "nov"
			when 12    #compare to 2
			  actualMes = "dec"
			end  			

			per = PeriodoParaIngresar.where("valor LIKE ?", "#{actualMes}%#{anio}").first
			if per == nil
				case mes # a_variable is the variable we want to compare
				when 1    #compare to 1
				  actualMes = "Ene"
				when 2    #compare to 2
				  actualMes = "Feb"
				when 3    #compare to 2
				  actualMes = "Mar"
				when 4    #compare to 2
				  actualMes = "Abr"	
				when 5    #compare to 2
				  actualMes = "May"
				when 6    #compare to 2
				  actualMes = "Jun"
				when 7    #compare to 2
				  actualMes = "Jul"
				when 8    #compare to 2
				  actualMes = "Ago"
				when 9    #compare to 2
				  actualMes = "Sep"
				when 10    #compare to 2
				  actualMes = "Oct"
				when 11    #compare to 2
				  actualMes = "Nov"
				when 12    #compare to 2
				  actualMes = "Dec"
				end  
				per = PeriodoParaIngresar.where("valor LIKE ?", "#{actualMes}%#{anio}").first
				if per == nil
					per = PeriodoParaIngresar.where(:valor=>backup).first
				end

			end
			if per != nil
				#raise "#{per[:id]}"
				record.periodo_para_ingresar = per
			end
  		end   		  		
  		record.save!(validate: false) 		
  	end  	
  end

  def down
  end
end
