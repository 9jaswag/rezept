# == Schema Information
#
# Table name: recipis
#
#  id                      :bigint(8)        not null, primary key
#  ingredients             :string           is an Array
#  name                    :string
#  preparation_description :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  owner_id                :bigint(8)
#
# Indexes
#
#  index_recipis_on_name      (name)
#  index_recipis_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#

class Recipi < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_one_attached :image

  validates :name, presence: true
  validates :ingredients, presence: true
  validates :preparation_description, presence: true
  validate :image_validation


  private
  def image_validation
    if image.attached?
      if image.blob.byte_size > 1000000
        image.purge
        errors[:base] << 'Image is too large.'
      elsif !image.blob.content_type.starts_with?('image/')
        image.purge
        errors[:base] << 'Wrong format provided.'
      end
    end
  end
end
