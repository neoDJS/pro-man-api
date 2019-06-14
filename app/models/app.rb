class App < ApplicationRecord
    belongs_to :user
    after_initialize :set_token
    #, class_name: "Admin", foreign_key: 'user_id' #:user, -> { where admin: true }, dependent: :destroy

    def self.current_app
        @@current_app
    end

    def set_current_app
        @@current_app = self
    end

    def uuid
        DateTime.now.to_s.gsub(/[-:]/, "")[0..14].chars.map{|a| rand(10).to_s}.join 
    end

    def set_token
        tokenPad = self.user.name + self.name
        md5 = Digest::MD5.new      
         
        self.key = self.uuid
        self.secret = md5.hexdigest(tokenPad) 
    end
end