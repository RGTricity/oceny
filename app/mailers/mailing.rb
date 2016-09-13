class Mailing < ActionMailer::Base
  default from: 'team@railsgirlstricity.pl'

  def after_submission(id)
    submission = Submission.find(id)
    mail(to: submission.email, subject: 'Rails Girls Kraków 2016: Thank you for your submission')
  end
end
