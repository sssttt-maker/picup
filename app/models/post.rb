class Post < ApplicationRecord
    mount_uploader :postimg, PostimgUploader
    belongs_to :user
    validates :comment_content, presence: true, length: { maximum: 255 }
    
    has_many :favorites, foreign_key: 'post_id', dependent: :destroy
    has_many :users, through: :favorites
    has_many :comments
end
