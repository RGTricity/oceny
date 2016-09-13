class FormsController < ApplicationController
  layout 'form'

  skip_before_action :authenticate
  before_action :set_custom_headers
  before_action :check_if_registration_open, only: [:show, :submit]

  def show
    submission = Submission.new

    render :show, locals: { submission: submission }
  end

  def submit
    submission = Submission.new(submission_params)

    if submission.save
      Mailing.after_submission(submission.id.to_s).deliver_now
      redirect_to(thanks_path)
    else
      render :show, locals: { submission: submission }
    end
  end

  def thanks
  end

  def closed
  end

  private

  def set_custom_headers
    response.headers['X-Frame-Options'] = 'ALLOWALL'
  end

  def form_params
    params.permit(:permalink)
  end

  def submission_params
    params.require(:submission).permit(:fullname, :email, :age, :about, :os,
      :been_before, :reason, :english, :extra, :partner, :adult, :accepts_rules, :experience => [:html, :css, :js,
      :databases, :rails, :programming])
  end

  def check_if_registration_open
    redirect_to closed_path unless Registration.open?
  end
end
