class Profile < ApplicationRecord
  belongs_to :user, optional: true
 
  has_attached_file :fb_thumb, default_url: "invicto_avatar.png"
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "50x50>" }, default_url: "invicto_avatar.png"
  has_attached_file :cover, default_url: "invicto_cover.jpg"

  validates_attachment_content_type :fb_thumb, content_type: ['image/jpeg', 'image/png']
  validates_attachment_content_type :avatar, content_type: ['image/jpeg', 'image/png']
  validates_attachment_content_type :cover, content_type: ['image/jpeg', 'image/png']
  validates_with AttachmentSizeValidator, attributes: :fb_thumb, less_than: 2.megabytes
  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 2.megabytes
  validates_with AttachmentSizeValidator, attributes: :cover, less_than: 2.megabytes
end
