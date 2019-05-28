class User < ApplicationRecord
    has_secure_password
    validates_presence_of :name, :email, :password
    validates :email, uniqueness: true
    has_many :grids
  
    def slug
      self.name.gsub(/\W/, '-')
    end
  
    def self.find_by_slug(slugified)
      self.find{|u| u.slug == slugified}
    end
end
