module UsersHelper
  def gravatar_for user
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    gravatar_url = [Settings.url.gravatar, gravatar_id].join
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end
end
