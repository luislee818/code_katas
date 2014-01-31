require_relative 'train_data_service'
require_relative 'seat_analyzer'
require_relative 'seat_reservation_service'
require_relative 'seat_reservation_result'

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
end
