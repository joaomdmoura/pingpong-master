class Game < ActiveRecord::Base
  belongs_to :player, class_name: 'User', foreign_key: 'player_id'
  belongs_to :opponent, class_name: 'User', foreign_key: 'opponent_id'

  validates :player, :opponent, :played_at, :player_score, :opponent_score, presence: true
  validates :player_score, :opponent_score, numericality: { only_integer: true, less_than: 22 }
  validates :player_score, score_difference: true
  validates :played_at, in_past: true

  before_save :compute_result
  before_save :update_players_rating

  def score
    "#{player_score} - #{opponent_score}"
  end

  private

  def compute_result
    self.result = player_won? ? 'W' : 'L'
  end

  def player_won?
    (player_score > opponent_score)
  end

  def update_players_rating
    k_value = 32
    result = player_won? ? 1 : 0

    player_expectation = 1/(1+10**((opponent.rating - player.rating)/400.0))
    opponent_expectation = 1/(1+10**((player.rating - opponent.rating)/400.0))

    player_rating = player.rating + (k_value*(result - player_expectation))
    opponent_rating = opponent.rating + (k_value*((1 - result) - opponent_expectation))

    User.transaction do
      player.update!(rating: player_rating)
      opponent.update!(rating: opponent_rating)
    end
  end
end
