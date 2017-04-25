class User < ActiveRecord::Base
  after_initialize { self.role ||= :standard }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  has_many :wikis
  has_many :collaborators
  has_many :wiki_collaborations, through: :collaborators, source: :wiki
  
  enum role: [:admin, :standard, :premium]
end
