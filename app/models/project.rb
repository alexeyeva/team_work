class Project < ActiveRecord::Base
  validates_presence_of :title , :text
  validates_uniqueness_of :title

  belongs_to :owner, class_name: "User", foreign_key: :owner_id
  has_and_belongs_to_many :users
  has_many :comments, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
end
