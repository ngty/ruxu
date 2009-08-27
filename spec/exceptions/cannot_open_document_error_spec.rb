require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'spec_helper.rb');

describe Ruxu::CannotOpenDocumentError do

  it_should_behave_like 'standard setup'

  def error
    Ruxu::CannotOpenDocumentError
  end

  def open(file)
    dir = File.expand_path(File.dirname(__FILE__))
    @runner.open('file://' + File.join(dir, '..', 'fixtures', file))
  end

  after(:each) do
    @runner.close
  end

  it 'should not be raised for valid document' do
    lambda { open('window.xul') }.should_not raise_error(error)
  end

  it 'should be raised for invalid document' do
    lambda { open('invalid_windows.xul') }.should raise_error(error)
  end

end
