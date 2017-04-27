class AddAttachmentAvatarToInterests < ActiveRecord::Migration
  def self.up
    change_table :interests do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :interests, :avatar
  end
end
