class CreateSetups < ActiveRecord::Migration
  def change
    create_table :setups do |t|
      t.boolean :performance_comments, default: false
      t.integer :performance_length
      t.boolean :project_life_cycle, default: false
      t.boolean :include_previous_departmental_actual, default: false
      t.boolean :include_departmental_previous_comments, default: false
      t.boolean :include_departmental_next_target, default: false
      t.boolean :include_toplayer_previous_target, default: false
      t.boolean :include_toplayer_next_target, default: false
      t.boolean :include_toplayer_previous_comments, default: false
      t.boolean :attach_poe, default: false
      t.timestamps null: false
    end
  end
end
