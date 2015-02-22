class AddWorkFlowFieldToCall < Mongoid::Migration
  def self.up
    Call.where(work_flow: nil).update_all(work_flow: :normal)
  end

  def self.down
  end
end
