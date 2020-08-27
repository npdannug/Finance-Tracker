class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  validates :first_name, presence: true, length: { minimum: 3, length: 15 }
  validates :last_name, presence: true, length: { minimum: 3, length: 15 }
  has_many :friendships
  has_many :friends, through: :friendships
    
  

  def stock_already_tracked?(ticker_symbol)
  	stock = Stock.check_db(ticker_symbol)
  	return false unless stock
  	stocks.where(id: stock.id).exists?
  end

  def under_stock_limit?
  	stocks.count < 10
  end

  def can_track_stock?(ticker_symbol)
  	under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end

  def full_name    
  	return "#{first_name.capitalize} #{last_name.capitalize}" if first_name || last_name
  	"My Profile"
  end

  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")
  end

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.last_name_matches(param)
    matches('last_name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  def self.search(param)
    param.strip!
    results = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    return nil unless  results
    results
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  def not_friend_with?(friend_id)
    !self.friends.where(id: friend_id).exists?
  end
end
