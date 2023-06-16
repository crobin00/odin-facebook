class Post < ApplicationRecord
  validates :author_id, presence: true
  validates :body, presence: true 
  validate :acceptable_photo

  belongs_to :author, class_name: "User"
  has_one_attached :photo, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :comments, dependent: :destroy

  def acceptable_photo
    return unless photo.attached?

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(photo.content_type)
      errors.add(:photo, "must be a JPEG OR PNG")
    end
  end
end
