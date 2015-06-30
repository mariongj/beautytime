class AddAttachmentPicture3ToBusinesses < ActiveRecord::Migration
  def self.up
    change_table :institutes do |t|
      t.attachment :picture3
    end
  end

  def self.down
    remove_attachment :institutes, :picture3
  end
end
