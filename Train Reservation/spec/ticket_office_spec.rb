require_relative '../lib/ticket_office'

module TrainReservationKata
  describe "TicketOffice" do
    describe "book_seats" do
      it "should invoke get_train_data on TrainDataService" do
        ticket_office = TicketOffice.new
        train_data_svc = double("train_data_svc")
        ticket_office.train_data_service = train_data_svc
        expect(train_data_svc).to receive(:get_train_data)
        reservation_result = ticket_office.book_seats("express_2000", 2)
      end
    end
  end
end
