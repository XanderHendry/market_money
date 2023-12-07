require 'rails_helper'

RSpec.describe ErrorMessage do
  it 'exists' do
    message = ErrorMessage.new('error messaging test', 666)
    expect(message).to be_a(ErrorMessage)
    expect(message).to respond_to(:message)
    expect(message).to respond_to(:status_code)
  end
end
