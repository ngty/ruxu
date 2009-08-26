require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'spec_helper.rb');

describe Ruxu::JavascriptRuntimeError do

  it_should_behave_like 'standard setup'

  it 'should not be raised for valid javascript' do
    lambda {
      runner.send('var xyz = 123')
    }.should_not raise_error(Ruxu::JavascriptRuntimeError)
  end

  it 'should be raised upon javascript syntax error' do
    lambda {
      runner.send('function() {')
    }.should raise_error(Ruxu::JavascriptRuntimeError, /SyntaxError:/)
  end

  it 'should be raised upon javascript reference error' do
    lambda {
      runner.send('invalid.test()')
    }.should raise_error(Ruxu::JavascriptRuntimeError, /ReferenceError:/)
  end

end
