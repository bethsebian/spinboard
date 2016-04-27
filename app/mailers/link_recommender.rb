class LinkRecommender < ApplicationMailer
  def recommend(friend_contact, link_id)
    @link = Link.find(link_id)
    mail(to: friend_contact, subject: "Check out this link!")
  end
end
