class User < ApplicationRecord
    has_one :worker
    has_secure_password
    validates_presence_of :name, :email, :password
    validates :email, uniqueness: true
    validates :name, format: { without: /[0-9]/, message: "does not allow numbers" }
    # validates_presence_of :worker, allow_nil: true
    has_many :created_projects, class_name: "Project", foreign_key: "created_by_id"
    has_many :created_todos, class_name: "Todo", foreign_key: "created_by_id"
    has_many :created_worker_todos, class_name: "WorkerTodo", foreign_key: "created_by_id"
    has_many :created_workers, class_name: "Worker", foreign_key: "created_by_id"
    has_many :updated_projects, class_name: "Project", foreign_key: "updated_by_id"
    has_many :updated_todos, class_name: "Todo", foreign_key: "updated_by_id"
    has_many :updated_worker_todos, class_name: "WorkerTodo", foreign_key: "updated_by_id"
    has_many :updated_workers, class_name: "Worker", foreign_key: "updated_by_id"
    scope :admins, -> { where(admin: true) }
    has_many :apps

    def self.current_user
        @@current_user
    end

    def set_current_user
        @@current_user = self
    end

    def get_token(app)
        tokenPad = self.name + app.name + DateTime.now.to_s
        sha256 = Digest::SHA2.new(256)
        api_token = sha256.hexdigest(tokenPad)
    end
  
    def slug
      self.name.gsub(/\W/, '-')
    end
  
    def self.find_by_slug(slugified)
      self.find{|u| u.slug == slugified}
    end
end