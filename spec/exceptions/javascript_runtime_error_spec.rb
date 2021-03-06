require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'spec_helper.rb');

describe Ruxu::JavascriptRuntimeError do

  it_should_behave_like 'standard setup'

  def error
    Ruxu::JavascriptRuntimeError
  end

  def send(cmd)
    @runner.send(cmd)
  end

  it 'should not be raised for valid javascript' do
    lambda { send('var xyz = 123') }.should_not raise_error(error)
  end

  it 'should be raised upon javascript syntax error' do
    lambda { send('function() {') }.should raise_error(error, /SyntaxError:/)
  end

  it 'should be raised upon javascript reference error' do
    lambda { send('invalid.test()') }.should raise_error(error, /ReferenceError:/)
  end

end
