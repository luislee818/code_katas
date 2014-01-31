require_relative '../lib/ticket_office'

module TrainReservationKata
  describe "TicketOffice" do
    describe "book_seats" do
      it "should invoke get_available_seats on TrainDataService" do
        ticket_office = TicketOffice.new

        train_data_svc = double("train_data_svc")
        expect(train_data_svc).to receive(:get_available_seats).and_return([])
        ticket_office.train_data_service = train_data_svc

        ticket_office.book_seats("express_2000", 2)
      end

      context "has available seats" do
        it "should invoke reserve_seats on SeatReservationService" do
          ticket_office = TicketOffice.new

          train_data_svc = double("train_data_svc")
          available_seats = ["1A", "1B"]
          allow(train_data_svc).to receive(:get_available_seats).and_return(available_seats)
          ticket_office.train_data_service = train_data_svc
          seat_reservation_svc = double("seat_reservation_svc")
          expect(seat_reservation_svc).to receive(:reserve_seats)
          ticket_office.seat_reservation_service = seat_reservation_svc

          ticket_office.book_seats("express_2000", 2)
        end
      end

      context "does not have available seats" do
        it "should not invoke reserve_seats on SeatReservationService" do
          ticket_office = TicketOffice.new

          train_data_svc = double("train_data_svc")
          available_seats = []
          allow(train_data_svc).to receive(:get_available_seats).and_return(available_seats)
          ticket_office.train_data_service = train_data_svc
          seat_reservation_svc = double("seat_reservation_svc")
          expect(seat_reservation_svc).to_not receive(:reserve_seats)
          ticket_office.seat_reservation_service = seat_reservation_svc

          ticket_office.book_seats("express_2000", 2)
        end
      end
    end
  end
end
