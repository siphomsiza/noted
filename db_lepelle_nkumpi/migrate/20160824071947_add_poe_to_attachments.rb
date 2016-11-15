class AddPoeToAttachments < ActiveRecord::Migration
  def self.up
    change_table :attachments do |t|
      t.attachment :poe
    end
  end

  def self.down
    drop_attached_file :attachments, :poe
  end
end
