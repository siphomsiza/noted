class AddLogoToMasterSetups < ActiveRecord::Migration
  def self.up
    change_table :master_setups, force: :cascade do |t|
      t.attachment :logo
    end
  end

  def self.down
    drop_attached_file :master_setups, :logo
  end
end
