class User < ActiveRecord::Base
  after_initialize { self.role ||= :standard }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  has_many :wikis
  
  enum role: [:admin, :standard, :premium]
end
