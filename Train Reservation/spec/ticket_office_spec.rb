require_relative '../lib/ticket_office'

module TrainReservationKata
  describe "TicketOffice" do
    describe "book_seats" do
      it "should invoke get_train_data on TrainDataService" do
        ticket_office = TicketOffice.new

        train_data_svc = double("train_data_svc")
        expect(train_data_svc).to receive(:get_train_data)
        ticket_office.train_data_service = train_data_svc

        ticket_office.book_seats("express_2000", 2)
      end

      it "should invoke get_available_seats on SeatAnalyzer" do
        ticket_office = TicketOffice.new

        train_data_svc = double("train_data_svc")
        allow(train_data_svc).to receive(:get_train_data)
        ticket_office.train_data_service = train_data_svc
        seat_analyzer = double("seat_analyzer")
        expect(seat_analyzer).to receive(:get_available_seats).and_return([])
        ticket_office.seat_analyzer = seat_analyzer

        ticket_office.book_seats("express_2000", 2)
      end

      context "has available seats" do
        it "should invoke reserve_seats on SeatReservationService" do
          ticket_office = TicketOffice.new

          train_data_svc = double("train_data_svc")
          allow(train_data_svc).to receive(:get_train_data)
          ticket_office.train_data_service = train_data_svc
          seat_analyzer = double("seat_analyzer")
          available_seats = ["1A", "1B"]
          allow(seat_analyzer).to receive(:get_available_seats).and_return(available_seats)
          ticket_office.seat_analyzer = seat_analyzer
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
          allow(train_data_svc).to receive(:get_train_data)
          ticket_office.train_data_service = train_data_svc
          seat_analyzer = double("seat_analyzer")
          available_seats = []
          allow(seat_analyzer).to receive(:get_available_seats).and_return(available_seats)
          ticket_office.seat_analyzer = seat_analyzer
          seat_reservation_svc = double("seat_reservation_svc")
          expect(seat_reservation_svc).to_not receive(:reserve_seats)
          ticket_office.seat_reservation_service = seat_reservation_svc

          ticket_office.book_seats("express_2000", 2)
        end
      end
    end
  end
end
