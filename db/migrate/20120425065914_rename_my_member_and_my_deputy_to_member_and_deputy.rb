class RenameMyMemberAndMyDeputyToMemberAndDeputy < Mongoid::Migration
  def self.up
    PositionApplication.all.each do |a|
      a[:member_id] = a[:my_member_id] if a[:my_member_id]
      a[:deputy_id] = a[:my_deputy_id] if a[:my_deputy_id]
      a.remove_attribute(:my_member_id)
      a.remove_attribute(:my_deputy_id)
      a.save
    end
  end

  def self.down
    PositionApplication.all.each do |a|
      a[:my_member_id] = a[:member_id] if a[:member_id]
      a[:my_deputy_id] = a[:deputy_id] if a[:deputy_id]
      a.remove_attribute(:member_id)
      a.remove_attribute(:deputy_id)
      a.save
    end
  end
end
