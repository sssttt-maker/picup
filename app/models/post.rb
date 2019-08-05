class Post < ApplicationRecord
    mount_uploader :postimg, PostimgUploader
    belongs_to :user
    validates :content, presence: true, length: { maximum: 255 }
end
