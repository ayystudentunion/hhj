module OrgansHelper
  def manager
    [@organ.manager_name, @organ.manager_email].reject(&:blank?).join(', ')
  end

  def status_class_for(application)
    if show_recommendations?(application.call)
      application.admissible? && application.eligible? ? 'valid' : 'invalid'
    else
      ''
    end
  end
end
