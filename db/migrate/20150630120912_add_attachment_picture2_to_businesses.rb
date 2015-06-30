class AddAttachmentPicture2ToBusinesses < ActiveRecord::Migration
  def self.up
    change_table :institutes do |t|
      t.attachment :picture2
    end
  end

  def self.down
    remove_attachment :institutes, :picture2
  end
end
