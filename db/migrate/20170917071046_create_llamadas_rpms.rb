class CreateLlamadasRpms < ActiveRecord::Migration
  def change
    create_table :llamadas_rpms do |t|
      t.boolean :realizadas
      t.boolean :pendientes
      t.boolean :por_realizar

      t.timestamps
    end
  end
end
