class AddLastSearchedProspectoToConfigurations < ActiveRecord::Migration
  def add
    add_column :configuraciones, :LastSearchProspecto, :text
    add_column :Configuraciones, :LastSearchSoliticante, :text
    add_column :Configuraciones, :LastSearchExaminado, :text
    add_column :Configuraciones, :LastSearchAdmitido, :text
    add_column :Configuraciones, :LastSearchInscrito, :text
  end
end
