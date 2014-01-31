
module TrainReservationKata
  class TicketOffice
    def self.book_seats(train_id, number_of_seats)
      SeatReservationResult.new(train_id, "foo", [1, 2])
    end
  end

  class SeatReservationResult
    attr_reader :train_id, :booking_reference, :seats

    def initialize(train_id, booking_reference, seats)
      @train_id = train_id
      @booking_reference = booking_reference
      @seats = seats
    end
  end
end
