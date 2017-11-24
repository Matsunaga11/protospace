class Prototype < ActiveRecord::Base
  MAX_PROTOTYPE_TAGS_LENGTH = 3
  belongs_to :user
  has_many :captured_images, dependent: :destroy
  has_many :likes
  has_many :comments
  has_many :tags, through: :prototype_tags, dependent: :destroy
  has_many :prototype_tags, dependent: :destroy

  accepts_nested_attributes_for :captured_images, reject_if: :reject_sub_images

  validates :title,
            :catch_copy,
            :concept,
            :tag_ids,
            presence: true
  validates :prototype_tags, length: {maximum: MAX_PROTOTYPE_TAGS_LENGTH}

  def reject_sub_images(attributed)
    attributed['content'].blank?
  end

  def set_main_thumbnail
    captured_images.main.first.content
  end

  def posted_date
    created_at.strftime('%b %d %a')
  end
end
