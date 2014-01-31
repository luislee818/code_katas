require_relative '../lib/ticket_office'

module TrainReservationKata
  describe "TicketOffice integration spec" do
    describe "when asking for reserving 2 seats on experss_2000" do
      it "should return successful reservation results" do
        ticket_office = TicketOffice.new
        reservation_result = ticket_office.book_seats("express_2000", 2)
        reservation_result.train_id.should == "express_2000"
        reservation_result.booking_reference.should_not == ""
        reservation_result.seats.size.should == 2
      end
    end
  end
end
