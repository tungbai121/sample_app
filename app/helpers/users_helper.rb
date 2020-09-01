module UsersHelper
  def gravatar_for user, options = {size: Settings.gravatar.default_size}
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    size = options[:size]
    gravatar_url = [Settings.url.gravatar, gravatar_id, "?s=", size].join
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end
end
