class AddAttachmentAvatarToLoans < ActiveRecord::Migration
  def self.up
    change_table :loans do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :loans, :avatar
  end
end
