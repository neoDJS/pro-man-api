class RegisteredApp < ApplicationRecord
    after_initialize :set_token
    belongs_to :admin #, class_name: "Admin", foreign_key: 'user_id' #:user, -> { where admin: true }, dependent: :destroy

    def set_token
        tokenPad = self.admin.name + self.name
        sha256 = Digest::SHA2.new(256)
        self.token = sha256.hexdigest(tokenPad)
    end
end