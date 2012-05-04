module OrgansHelper
  def manager
    [@organ.manager_name, @organ.manager_email].reject(&:blank?).join(', ')
  end
end
