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
		if i >= (score_sheet.size - 3)
			return get_raw_score_for_roll(score_sheet, i)
		end

    value = score_sheet[i]

    if value == '/'
			get_raw_score_for_roll(score_sheet, i) +
				get_raw_score_for_roll(score_sheet, i + 1)
		elsif value == 'X'
			get_raw_score_for_roll(score_sheet, i) +
				get_raw_score_for_roll(score_sheet, i + 1) +
				get_raw_score_for_roll(score_sheet, i + 2)
    elsif value == '-'
      0
    else
      value.to_i
    end
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

  describe "get_roll_score" do
    score_sheet = "7/8-X35X1/"

    it "should return the same number if it's not '/', '-' or 'X'" do
      roll_score = BowlingScoreCalculator.get_roll_score(score_sheet, 0)
      roll_score.should == 7
    end

    it "should return 0 if it's '-'" do
      roll_score = BowlingScoreCalculator.get_roll_score(score_sheet, 3)
      roll_score.should == 0
    end

    it "should return (10 - score) + next roll score if it's '/'" do
      roll_score = BowlingScoreCalculator.get_roll_score(score_sheet, 1)
      roll_score.should == 11
    end

    it "should return (10 - score) + next 2 roll scores if it's 'X'" do
      roll_score = BowlingScoreCalculator.get_roll_score(score_sheet, 4)
      roll_score.should == 18
    end

		context "'/' occurs in one of the last three rolls" do
			it "should return raw value of '/' when it occurs not as the last roll" do
				score_sheet = "7/8-X352/3"
				roll_score = BowlingScoreCalculator.get_roll_score(score_sheet, 8)
				roll_score.should == 8
			end

			it "should return raw value of '/' when it occurs as the last roll" do
				score_sheet = "7/8-X35X3/"
				roll_score = BowlingScoreCalculator.get_roll_score(score_sheet, 9)
				roll_score.should == 7
			end
		end

		context "'X' occurs in one of the last three rolls" do
			it "should return raw value of 'X' when it occurs not as the last roll" do
				score_sheet = "7/8-X35X53"
				roll_score = BowlingScoreCalculator.get_roll_score(score_sheet, 7)
				roll_score.should == 10
			end

			it "should return raw value of 'X' when it occurs as the last roll" do
				score_sheet = "7/8-X35XXX"
				roll_score = BowlingScoreCalculator.get_roll_score(score_sheet, 9)
				roll_score.should == 10
			end
		end
  end
end

describe "sample games" do
	describe "A game without strikes or spares" do
		it "should add up all the numbers as total score" do
			sheet = "12345123451234512345"
			result = BowlingScoreCalculator.get_total_score sheet
			result.should == 60
		end
	end

	describe "A game with all strikes" do
		it "should have score of 300" do
			sheet = "XXXXXXXXXXXX"
			result = BowlingScoreCalculator.get_total_score sheet
			result.should == 300
		end
	end

	describe "A game brokes player's heart" do
		it "should have score of 90" do
			sheet = "9-9-9-9-9-9-9-9-9-9-"
			result = BowlingScoreCalculator.get_total_score sheet
			result.should == 90
		end
	end

	describe "A game with all spares" do
		it "should have score of 150" do
			sheet = "5/5/5/5/5/5/5/5/5/5/5"
			result = BowlingScoreCalculator.get_total_score sheet
			result.should == 150
		end
	end
end
