class Micropost < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.content.length}
  validates :image, content_type: {
    in: Settings.image.types, message: I18n.t(".must_be_valid_format")
  }, size: {
    less_than: Settings.image.size.megabytes,
    message: I18n.t(".should_be_less_than", limit_size: Settings.image.size)
  }

  has_one_attached :image

  scope :order_by_created_at, ->{order created_at: :desc}
  scope :feed, (lambda do |user_id|
    where(user_id: Relationship.following_ids(user_id))
    .or(where(user_id: user_id))
  end)

  def display_image
    image.variant resize_to_limit: [Settings.image.width, Settings.image.height]
  end
end
