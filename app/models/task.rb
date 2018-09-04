class Task < ApplicationRecord
  belongs_to :user

  validates :status, presence: true, length: { maximum: 10 }

  private
    def logged_in
      if @user
        true
      else
        redirect_to signup_path
      end
    end
end
