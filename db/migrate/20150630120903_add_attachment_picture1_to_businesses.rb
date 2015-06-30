class AddAttachmentPicture1ToBusinesses < ActiveRecord::Migration
  def self.up
    change_table :institutes do |t|
      t.attachment :picture1
    end
  end

  def self.down
    remove_attachment :institutes, :picture1
  end
end
