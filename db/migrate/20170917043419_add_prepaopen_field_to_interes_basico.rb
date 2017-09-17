class AddPrepaopenFieldToInteresBasico < ActiveRecord::Migration
  def up
  	add_column :interes_basicos, :prepa_abierta, :string
  	InteresBasico.find_each do |record|

  		if record.preparatoria_o_universidad_de_origen != nil
  			record.prepa_abierta = record.preparatoria_o_universidad_de_origen.valor
  			record.save!(validate: false)
  		else
  			record.prepa_abierta = "Sin Valor"
  			record.save!(validate: false)
  		end
  	end
  end
  def down
  	remove_column :interes_basicos, :prepa_abierta

  end
end
