class RemoveSinValorFromDireccions < ActiveRecord::Migration
  def up
  	Direccion.find_each do |record|
  		if record.no_interior_texto == "Sin Valor"
  			record.no_interior_texto = ""
  			record.save!(validate: false)
  		end
  		if record.no_exterior_texto == "Sin Valor"
  			record.no_exterior_texto = ""
  			record.save!(validate: false)
  		end  		
  	end
  end

  def down
  end
end
