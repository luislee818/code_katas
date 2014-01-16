class BowlingScoreCalculator
  STRIKE = 'X'
  SPARE = '/'
  MISS = '-'
  NON_BONUS_ROLLS_COUNT = 3

  def self.get_total_score(score_sheet)
    i = 0
    score = 0
    loop do
      roll_score = get_roll_score(score_sheet, i)
      score += roll_score
      i += 1
      break if i == score_sheet.size
    end
    score
  end

  def self.get_roll_score(score_sheet, i)
    if i >= (score_sheet.size - NON_BONUS_ROLLS_COUNT)
      return get_raw_score_for_roll(score_sheet, i)
    end

    value = score_sheet[i]

    if value == SPARE
      get_raw_score_for_roll(score_sheet, i) +
        get_raw_score_for_roll(score_sheet, i + 1)
    elsif value == STRIKE
      get_raw_score_for_roll(score_sheet, i) +
        get_raw_score_for_roll(score_sheet, i + 1) +
        get_raw_score_for_roll(score_sheet, i + 2)
    elsif value == MISS
      0
    else
      value.to_i
    end
  end

  def self.get_raw_score_for_roll(score_sheet, i)
    value = score_sheet[i]

    if value == SPARE
      previous_value = score_sheet[i - 1]
      10 - previous_value.to_i
    elsif value == STRIKE
      10
    elsif value == MISS
      0
    else
      value.to_i
    end
  end
end
