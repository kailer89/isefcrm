class Assd < ActiveRecord::Migration
   def up
    add_column :configuraciones, :LastSearchProspecto, :text
    add_column :configuraciones, :LastSearchSoliticante, :text
    add_column :configuraciones, :LastSearchExaminado, :text
    add_column :configuraciones, :LastSearchAdmitido, :text
    add_column :configuraciones, :LastSearchInscrito, :text
  end
end
