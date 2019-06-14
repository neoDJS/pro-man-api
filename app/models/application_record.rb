class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  belongs_to :from_app, class_name: "App"
  belongs_to :created_by, class_name: "User"
  belongs_to :updated_by, class_name: "User"

  before_validation :set_from_app, on: [:create, :update]
  before_validation :set_created_by, on: :create
  before_validation :set_updated_by, on: :update

  def set_created_by
    self.created_by = User.current_user
    self.updated_by = User.current_user
  end

  def set_updated_by
    self.updated_by = User.current_user
  end


  def set_from_app
    self.from_app = App.current_app
  end
end
