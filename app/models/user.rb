class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :my_projects, class_name: "Project", foreign_key: :owner_id
   has_many :comments, foreign_key: :owner_id
   has_and_belongs_to_many :projects

   validates_presence_of :name

   scope :free_users, -> (project) { User.where.not(id: (project.user_ids + [project.owner.id])) }

   # def self.free_users(project)
   #    ids = project.user_ids << project.owner.id
   #    User.where.not(id: ids)
   # end
 end
