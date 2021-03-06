class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable

  has_many :games_as_player, foreign_key: 'player_id', class_name: 'Game'
  has_many :games_as_opponent, foreign_key: 'opponent_id', class_name: 'Game'

  scope :all_except, ->(user) { where.not(id: user) }

  def games
    games_as_player + games_as_opponent
  end
end
