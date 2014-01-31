require_relative '../lib/train_data_service'

module TrainReservationKata
  describe "TrainDataService" do
    describe "parse_json" do
      it "should return an object with train data" do
        service = TrainDataService.new

        raw_json = %Q[{"seats": {"1A": {"booking_reference": "", "seat_number": "1", "coach": "A"}, "2A": {"booking_reference": "", "seat_number": "2", "coach": "A"}}}]

        result = service.send(:parse_json, raw_json)
        result.seats.size.should == 2
        result.seats[0].should == SeatInfo.new("1A", "", "1", "A")
        result.seats[1].should == SeatInfo.new("2A", "", "2", "A")
      end
    end
  end
end
