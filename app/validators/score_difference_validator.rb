class ScoreDifferenceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless valid_score_difference(record)
      record.errors.add attribute, (options[:message] || "game needs to be won by a two point margin")
    end
  end

  private

    def valid_score_difference(record)
      record.player_score &&
      record.opponent_score &&
      (record.player_score - record.opponent_score).abs >= 2
    end
end
