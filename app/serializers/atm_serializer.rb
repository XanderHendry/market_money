class AtmSerializer
  attr_reader :error_object

  def initialize(atm_service_response)
    @nearby_atms = atm_service_response
  end

  def serialize_json
    serialized_hash = {
      data: []
    }
    @nearby_atms[:results].each do |atm|
      serialized_hash[:data] << {
        id: nil,
        type: 'atm',
        attributes: {
          name: atm[:poi][:name],
          address: atm[:address][:freeformAddress],
          lat: atm[:position][:lat],
          lon: atm[:position][:lon],
          distance: atm[:dist]
        }
      }
    end
    serialized_hash
  end
end
