require 'rails_helper'

RSpec.describe ErrorSerializer do
  before(:each) do
    message = ErrorMessage.new('error messaging test', 666)
    @serializer = ErrorSerializer.new(message)
  end
  it 'exists' do
    expect(@serializer).to respond_to(:error_object)
  end
  describe '#serialize_json' do
    it 'parses info from a ErrorMessage object into JSON' do
      output = @serializer.serialize_json
      expect(output).to be_a(Hash)

      expect(output).to have_key(:errors)
      expect(output[:errors]).to be_an(Array)

      output[:errors].each do |error|
        expect(error).to be_a(Hash)

        expect(error).to have_key(:status)
        expect(error).to have_key(:title)
      end
    end
  end
end
