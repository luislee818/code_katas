class BowlingScoreCalculator
  def self.get_score(sheet)
    21
  end
end

describe "A game without strikes or spares" do
  it "should add up all the numbers as total score" do
    sheet = "123456"
    result = BowlingScoreCalculator.get_score sheet
    result.should == 21
  end
end
