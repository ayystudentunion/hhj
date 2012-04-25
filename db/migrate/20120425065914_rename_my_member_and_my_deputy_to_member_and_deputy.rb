class RenameMyMemberAndMyDeputyToMemberAndDeputy < Mongoid::Migration
  def self.up
    PositionApplication.all.each do |a|
      a.member = a.my_member
      a.deputy = a.my_deputy
      a.save
    end
  end

  def self.down
    PositionApplication.all.each do |a|
      a.my_member = a.member
      a.my_deputy = a.deputy
      a.save
    end
  end
end
