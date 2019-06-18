class App < ApplicationRecord
    belongs_to :user
    has_many :sessions
    before_validation :set_token, on: :create
    #, class_name: "Admin", foreign_key: 'user_id' #:user, -> { where admin: true }, dependent: :destroy

    def self.current_app
        @@current_app
    end

    def set_current_app
        @@current_app = self
    end

    def wired?
        self.wired
    end

    def set_wired
        user.set_current_user
        self.set_current_app
        # self.toggle!(:wired)
        self.wired = true
        self.save!
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