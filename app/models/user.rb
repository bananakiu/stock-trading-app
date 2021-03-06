class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  
  has_and_belongs_to_many :roles, :dependent => :delete_all
  has_many :transactions, :dependent => :delete_all
  has_many :portfolios, :dependent => :delete_all

  # set default role (https://stackoverflow.com/questions/17207614/how-to-populate-data-in-roles-users-table-using-devise-in-rails)
  before_create :set_default_role

  # validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  private
  def set_default_role
    # Add the default role if no roles is set
    self.roles << Role.find_by_name('member') if roles.empty?
  end
end
