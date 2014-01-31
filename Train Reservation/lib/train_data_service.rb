require 'json'

module TrainReservationKata
  class TrainDataService
    def get_train_data
    end

    def get_available_seats
      []
    end

    private
    def parse_json(json)
      hash = JSON.parse json
      seats_hash = hash["seats"]
      seats = []

      seats_hash.each do |key, value|
        id = key
        booking_reference = value["booking_reference"]
        seat_number = value["seat_number"]
        coach = value["coach"]

        seat_info = SeatInfo.new(id, booking_reference, seat_number, coach)
        seats << seat_info
      end

      TrainInfo.new(seats)
    end
  end

  TrainInfo = Struct.new(:seats)

  SeatInfo = Struct.new(:id, :booking_reference, :seat_number, :coach) do
    def ==(other)
      self.id == other.id and self.booking_reference == other.booking_reference and
        self.seat_number == other.seat_number and self.coach == other.coach
    end
  end
end
