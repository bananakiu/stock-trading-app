class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  
  has_and_belongs_to_many :roles
  has_many :transactions
  has_many :portfolios

  # set default role (https://stackoverflow.com/questions/17207614/how-to-populate-data-in-roles-users-table-using-devise-in-rails)
  before_create :set_default_role

  private
  def set_default_role
    # Add the default role if no roles is set
    self.roles << Role.find_by_name('member') if roles.empty?
  end

  protected
  def confirmation_required?
    false
  end
end
