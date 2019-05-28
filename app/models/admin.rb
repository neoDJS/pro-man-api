class Admin < ApplicationRecord
    has_many :apps, class_name: "RegisteredApp"
end
