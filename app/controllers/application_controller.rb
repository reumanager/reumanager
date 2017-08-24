class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper
  before_filter :log_x_forwarded_by
  helper_method :expired?

  protected

  def check_deadline
    if expired?
      redirect_to closed_url
    end
  end

  def log_x_forwarded_by
    if request.env["HTTP_X_FORWARDED_FOR"].nil?
      Rails.logger.info "NO HTTP_X_FORWARDED_FOR"
    else
      Rails.logger.info "REMOTE IP: " + request.env["HTTP_X_FORWARDED_FOR"].split(',').first
    end
  end

  def set_state
    current_applicant.set_state
  end



end
