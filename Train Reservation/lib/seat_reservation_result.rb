module TrainReservationKata
  class SeatReservationResult
    attr_reader :train_id, :booking_reference, :seats

    def initialize(train_id, booking_reference, seats)
      @train_id = train_id
      @booking_reference = booking_reference
      @seats = seats
    end
  end
end
