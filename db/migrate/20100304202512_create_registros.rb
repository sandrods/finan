class CreateRegistros < ActiveRecord::Migration
  def self.up
    create_table :registros, :force => true do |t|

      t.date      :data
      t.string    :descricao, :limit=>60
      t.decimal   :valor,                  :scale=>5, :precision=>2,   :null=>false     
      t.string    :cd,        :limit => 1
      t.boolean   :conciliado 
      
      t.timestamps
    end
  end

  def self.down
    drop_table :registros
  end
end
