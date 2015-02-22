class MemberHallopedToGroup < Mongoid::Migration
  def self.up
    Member.where(halloped: true, group: nil).update_all(group: :group_hallopeds)
    Member.where(halloped: false, group: nil).update_all(group: :group_staff)
    Member.db.collection('members').update({},{ '$unset' => { 'halloped' => 1 } }, multi: true)
  end

  def self.down
    Member.where(group: :group_hallopeds).update_all(halloped: true)
    Member.where(group: :group_staff).update_all(halloped: false)
  end
end
