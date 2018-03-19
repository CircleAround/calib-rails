RSpec.describe Calib::Lang::Namespace do
  describe '.as_modules' do
    it { expect(Calib::Lang::Namespace.as_modules(Calib::Lang::Namespace)).to eql [Calib, Calib::Lang] }
    it { expect(Calib::Lang::Namespace.as_modules(Calib::Lang)).to eql [Calib] }
    it { expect(Calib::Lang::Namespace.as_modules(String)).to eql [] }
  end

  describe '.as_symbols' do
    it { expect(Calib::Lang::Namespace.as_symbols(Calib::Lang::Namespace)).to eql [:calib, :lang] }
    it { expect(Calib::Lang::Namespace.as_symbols(Calib::Lang)).to eql [:calib] }
    it { expect(Calib::Lang::Namespace.as_symbols(String)).to eql [] }
  end
end