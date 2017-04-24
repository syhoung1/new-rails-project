class User < ActiveRecord::Base
  after_initialize { self.role ||= :standard }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  has_many :collaborators
  has_many :wikis, through: :collaborators
  
  enum role: [:admin, :standard, :premium]
end
