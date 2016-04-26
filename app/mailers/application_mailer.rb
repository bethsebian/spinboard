class ApplicationMailer < ActionMailer::Base
  default from: "no_reply@link_recommender.io"
  layout 'mailer'
end
