class AddArchivedFieldAsFalse < Mongoid::Migration
  def self.up
    Call.where(archived: nil).update_all(archived: false)
  end

  def self.down
  end
end
