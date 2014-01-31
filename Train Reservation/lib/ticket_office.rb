module TrainReservationKata
  class TicketOffice
    attr_writer :train_data_service, :seat_analyzer, :seat_reservation_service

    def book_seats(train_id, number_of_seats)
      train_data_service.get_train_data
      available_seats = seat_analyzer.get_available_seats
      seat_reservation_service.reserve_seats unless available_seats.empty?
      SeatReservationResult.new(train_id, "foo", [1, 2])
    end

    def train_data_service
      @train_data_service || TrainDataService.new
    end

    def seat_analyzer
      @seat_analyzer || SeatAnalyzer.new
    end

    def seat_reservation_service
      @seat_reservation_service || SeatReservationService.new
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

  class SeatAnalyzer
    def get_available_seats
      []
    end
  end

  class SeatReservationService
    def reserve_seats
    end
  end
end
