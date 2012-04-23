class CallStatusToSingleField < Mongoid::Migration
  def self.up
    Call.where(closed: nil).update_all(status: :open)
    Call.where(closed: false).update_all(status: :open)
    Call.where(closed: true).update_all(status: :closed)
    Call.where(archived: true).update_all(status: :archived)
  end

  def self.down
  end
end
