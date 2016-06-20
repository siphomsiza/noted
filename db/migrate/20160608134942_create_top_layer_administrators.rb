class CreateTopLayerAdministrators < ActiveRecord::Migration
  def change
    create_table :top_layer_administrators do |t|

      t.timestamps null: false
    end
  end
end
