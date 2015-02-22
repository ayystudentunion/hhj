class RenameWorkFlowToWorkflow < Mongoid::Migration
  def self.up
    Call.db.collection('calls').update({},{ '$rename' => { 'work_flow' => 'workflow' } }, multi: true)
    Call.where(workflow: :normal).update_all(workflow: :workflow_normal)
    Call.where(workflow: :administration_election).update_all(workflow: :workflow_administration_election)
    Call.where(workflow: :proposal_available).update_all(workflow: :workflow_proposal_available)
  end

  def self.down
    Call.where(workflow: :workflow_normal).update_all(workflow: :normal)
    Call.where(workflow: :workflow_administration_election).update_all(workflow: :administration_election)
    Call.where(workflow: :workflow_proposal_available).update_all(workflow: :proposal_available)
    Call.db.collection('calls').update({},{ '$rename' => { 'workflow' => 'work_flow' } }, multi: true)
  end
end
