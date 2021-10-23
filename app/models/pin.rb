class Pin < ApplicationRecord
    belongs_to :user
    has_one_attached :image
    
    validates :image, presence: true
    validate :correct_image

    private
    def correct_image
        if !image.content_type.in?(%w(image/png image/jpeg image/jpg))
            errors.add(:image, 'must be a JPG/JPEG/PNG.')
        end
    end
end
