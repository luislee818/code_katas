module TrainReservationKata
  class TicketOffice
    attr_writer :train_data_service

    def book_seats(train_id, number_of_seats)
      train_data_service.get_train_data
      SeatReservationResult.new(train_id, "foo", [1, 2])
    end

    def train_data_service
      @train_data_service || TrainDataService.new
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

  class TrainDataService
    def get_train_data
    end
  end
end
