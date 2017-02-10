class AddAttachmentFbThumbToProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.attachment :fb_thumb
    end
  end

  def self.down
    remove_attachment :profiles, :fb_thumb
  end
end
