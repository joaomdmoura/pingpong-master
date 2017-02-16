class Game < ActiveRecord::Base
  belongs_to :player, class_name: 'User', foreign_key: 'player_id'
  belongs_to :opponent, class_name: 'User', foreign_key: 'opponent_id'

  validates :player, :opponent, :played_at, :player_score, :opponent_score, presence: true
  validates :player_score, :opponent_score, numericality: { only_integer: true }
  validates :played_at, in_past: true
end
