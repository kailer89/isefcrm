class Compartido
	#require_relative 'Shared' 




	def self.getProspectosForUser (user)

		archivado = false
	    modelo = Configuracione.where(:user_id=>user.id).first rescue nil
	    if modelo != nil
	      archivado = modelo.mostrar_archivados
	    end

		rol = Role.where(:id=>user.role).first

		if rol == nil
			return Prospecto.where(:archivado=>archivado).where(:sede_id=>user.sede).where(:user_id=>user.id)
		else
			if rol.nombre == "DN" or rol.nombre == "ACRM" 
				return Prospecto.where(:archivado=>archivado)
			else
				if rol.nombre == "D"

					return Prospecto.where(:archivado=>archivado).where(:sede_id=>user.sede)
				else

					return Prospecto.where(:archivado=>archivado).where(:sede_id=>user.sede).where(:user_id=>user.id)
				end #end director
			end #end else rol nombre
		end #end else nil

	end


	def self.getSolicitantesForUser (user)

		archivado = false
	    modelo = Configuracione.where(:user_id=>user.id).first rescue nil
	    if modelo != nil
	      archivado = modelo.mostrar_archivados
	    end

		rol = Role.where(:id=>user.role).first

		if rol == nil
			return Solicitante.where(:archivado=>archivado).where("prospecto_id in (:prospectos)",:prospectos=>Compartido.getProspectosForUser(user))
		else
			if rol.nombre == "DN" or rol.nombre == "ACRM" 
				return Solicitante.where(:archivado=>archivado).where("prospecto_id in (:prospectos)",:prospectos=>Compartido.getProspectosForUser(user))
			else
				if rol.nombre == "D"
					return Solicitante.where(:archivado=>archivado).where("prospecto_id in (:prospectos)",:prospectos=>Compartido.getProspectosForUser(user))
				else

					return Solicitante.where(:archivado=>archivado).where("prospecto_id in (:prospectos)",:prospectos=>Compartido.getProspectosForUser(user))
				end #end director
			end #end else rol nombre
		end #end else nil

	end



	def self.getExaminadosForUser (user)

		archivado = false
	    modelo = Configuracione.where(:user_id=>user.id).first rescue nil
	    if modelo != nil
	      archivado = modelo.mostrar_archivados
	    end

		rol = Role.where(:id=>user.role).first

		if rol == nil
			return Examinado.where(:archivado=>archivado).where("solicitante_id in (:solicitantes)",:solicitantes=>Compartido.getSolicitantesForUser(user).where("prospecto_id in (:prospectos)",:prospectos=>Compartido.getProspectosForUser(user).joins{solicitante}))
		else
			if rol.nombre == "DN" or rol.nombre == "ACRM" 
				return Examinado.where(:archivado=>archivado)
			else
				if rol.nombre == "D"
					return Examinado.where(:archivado=>archivado).where("solicitante_id in (:solicitantes)",:solicitantes=>Compartido.getSolicitantesForUser(user).where("prospecto_id in (:prospectos)",:prospectos=>Compartido.getProspectosForUser(user).joins{solicitante}))
				else

					return Examinado.where(:archivado=>archivado).where("solicitante_id in (:solicitantes)",:solicitantes=>Compartido.getSolicitantesForUser(user).where("prospecto_id in (:prospectos)",:prospectos=>Compartido.getProspectosForUser(user).joins{solicitante}))
				end #end director
			end #end else rol nombre
		end #end else nil

	end



	def self.getAdmitidosForUser (user)

		archivado = false
	    modelo = Configuracione.where(:user_id=>user.id).first rescue nil
	    if modelo != nil
	      archivado = modelo.mostrar_archivados
	    end

		rol = Role.where(:id=>user.role).first

		if rol == nil
			return Admitido.where(:archivado=>archivado).where("examinado_id in (:examinados)",:examinados=>Compartido.getExaminadosForUser(user).where("solicitante_id in (:solicitantes)",:solicitantes=>Compartido.getSolicitantesForUser(user).where("prospecto_id in (:prospectos)",:prospectos=>Compartido.getProspectosForUser(user).joins{solicitante})))
		else
			if rol.nombre == "DN" or rol.nombre == "ACRM" 
				return Admitido.where(:archivado=>archivado)
			else
				if rol.nombre == "D"
					return Admitido.where(:archivado=>archivado).where("examinado_id in (:examinados)",:examinados=>Compartido.getExaminadosForUser(user).where("solicitante_id in (:solicitantes)",:solicitantes=>Compartido.getSolicitantesForUser(user).where("prospecto_id in (:prospectos)",:prospectos=>Compartido.getProspectosForUser(user).joins{solicitante})))
				else

					return Admitido.where(:archivado=>archivado).where("examinado_id in (:examinados)",:examinados=>Compartido.getExaminadosForUser(user).where("solicitante_id in (:solicitantes)",:solicitantes=>Compartido.getSolicitantesForUser(user).where("prospecto_id in (:prospectos)",:prospectos=>Compartido.getProspectosForUser(user).joins{solicitante})))
				end #end director
			end #end else rol nombre
		end #end else nil

	end		

	def self.getInscritosForUser (user)

		archivado = false
	    modelo = Configuracione.where(:user_id=>user.id).first rescue nil
	    if modelo != nil
	      archivado = modelo.mostrar_archivados
	    end

		rol = Role.where(:id=>user.role).first

		if rol == nil
			return Inscrito.where(:archivado=>archivado).where("admitido_id in (:admitidos)",:admitidos=>Compartido.getAdmitidosForUser(user).where("examinado_id in (:examinados)",:examinados=>Compartido.getExaminadosForUser(user).where("solicitante_id in (:solicitantes)",:solicitantes=>Compartido.getSolicitantesForUser(user).where("prospecto_id in (:prospectos)",:prospectos=>Compartido.getProspectosForUser(user).joins{solicitante}))))
		else
			if rol.nombre == "DN" or rol.nombre == "ACRM" 
				return Inscrito.where(:archivado=>archivado)
			else
				if rol.nombre == "D"
					return Inscrito.where(:archivado=>archivado).where("admitido_id in (:admitidos)",:admitidos=>Compartido.getAdmitidosForUser(user).where("examinado_id in (:examinados)",:examinados=>Compartido.getExaminadosForUser(user).where("solicitante_id in (:solicitantes)",:solicitantes=>Compartido.getSolicitantesForUser(user).where("prospecto_id in (:prospectos)",:prospectos=>Compartido.getProspectosForUser(user).joins{solicitante}))))
				else

					return Inscrito.where(:archivado=>archivado).where("admitido_id in (:admitidos)",:admitidos=>Compartido.getAdmitidosForUser(user).where("examinado_id in (:examinados)",:examinados=>Compartido.getExaminadosForUser(user).where("solicitante_id in (:solicitantes)",:solicitantes=>Compartido.getSolicitantesForUser(user).where("prospecto_id in (:prospectos)",:prospectos=>Compartido.getProspectosForUser(user).joins{solicitante}))))
				end #end director
			end #end else rol nombre
		end #end else nil

	end



end