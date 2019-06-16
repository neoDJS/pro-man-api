class Session < ActiveRecord::Base
    belongs_to :user
    belongs_to :app

    def activity=(val)
    end
end
