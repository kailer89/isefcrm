class Migratedirections < ActiveRecord::Migration
  def up
  	add_column :direccions, :no_interior_texto, :string
  	add_column :direccions, :no_exterior_texto, :string
  	Direccion.find_each do |record|

  		if record.no_interior != nil
  			record.no_interior_texto = record.no_interior.to_s
  			record.no_exterior_texto = record.no_exterior.to_s
  			record.save!(validate: false)
  		else
  			record.no_interior_texto = "Sin Valor"
  			record.no_exterior_texto = "Sin Valor"
  			record.save!(validate: false)
  		end
  	end
  end
  def down
  	remove_column :direccions, :no_interior_texto
  	remove_column :direccions, :no_exterior_texto 

  end
end
