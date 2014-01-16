class BowlingScoreCalculator
  STRIKE = "X"

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
    score_sheet[i].to_i
  end

  def self.get_raw_score_for_roll(score_sheet, i)
    value = score_sheet[i]

    if value == '/'
      previous_value = score_sheet[i - 1]
      10 - previous_value.to_i
    elsif value == 'X'
      10
    elsif value == '-'
      0
    else
      value.to_i
    end
  end
end

describe "BowlingScoreCalculator" do
  describe "get_raw_score_for_roll" do
    score_sheet = "7/8-X35"

    it "should return the same number if it's not '/', '-' or 'X'" do
      raw_score = BowlingScoreCalculator.get_raw_score_for_roll(score_sheet, 0)
      raw_score.should == 7
    end

    it "should return the value of (10 - score) if it's '/'" do
      raw_score = BowlingScoreCalculator.get_raw_score_for_roll(score_sheet, 1)
      raw_score.should == 3
    end

    it "should return 0 if it's '-'" do
      raw_score = BowlingScoreCalculator.get_raw_score_for_roll(score_sheet, 3)
      raw_score.should == 0
    end

    it "should return 10 if it's 'X'" do
      raw_score = BowlingScoreCalculator.get_raw_score_for_roll(score_sheet, 4)
      raw_score.should == 10
    end
  end
end

describe "A game without strikes or spares" do
  xit "should add up all the numbers as total score" do
    sheet = "123456"
    result = BowlingScoreCalculator.get_total_score sheet
    result.should == 21
  end
end

describe "A game with all strikes" do
  xit "should have score of 300" do
    sheet = "XXXXXXXXXXXX"
    result = BowlingScoreCalculator.get_total_score sheet
    result.should == 300
  end
end
