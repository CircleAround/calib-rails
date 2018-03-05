require 'calib/service'
RSpec.describe Calib::Service do
  let(:service_class) do
    Struct.new(:call) do 
      include Calib::Service 
      def call
        123
      end
    end 
  end

  it "should call instance method 'call' without calling 'new'" do
    expect(service_class.call).to eql 123
  end
end