class Applicants::AcademicRecordsController < ApplicationController
  before_filter :authenticate_applicant!
  before_filter :set_state

  def edit
    current_applicant.records.build unless current_applicant.records.count > 0
    current_applicant.awards.build unless current_applicant.awards.count > 0

    render :edit
  end

  def update
    if current_applicant.update_attributes params[:applicant]
      current_applicant.can_complete_academic_info? ? current_applicant.complete_academic_info : current_applicant.incomplete_academic_info

      redirect_to current_applicant.redirect_url
    else
      render :edit
    end
  end

end
