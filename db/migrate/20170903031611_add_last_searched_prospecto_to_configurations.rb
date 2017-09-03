class AddLastSearchedProspectoToConfigurations < ActiveRecord::Migration
  def change
    add_column :Configuraciones, :LastSearchProspecto, :string
    add_column :Configuraciones, :LastSearchSoliticante, :string
    add_column :Configuraciones, :LastSearchExaminado, :string
    add_column :Configuraciones, :LastSearchAdmitido, :string
    add_column :Configuraciones, :LastSearchInscrito, :string
  end
end
