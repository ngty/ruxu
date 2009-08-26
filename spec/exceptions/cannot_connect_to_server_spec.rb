require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'spec_helper.rb');

describe Ruxu::CannotConnectToServer do

  def setup(args)
    @runner = Ruxu::Runner.new(
      :host    => args[:localhost] || 'localhost',
      :port    => args[:port]      || '4444',
      :binary  => args[:binary]    || 'firefox-3.5',
      :profile => args[:profile]   || 'UxU'
    )
  end

  def error
    Ruxu::CannotConnectToServer
  end

  after(:each) do
    @runner.close if @runner
  end

  it 'should not be raised for all valid args' do
    lambda { setup({}) }.
      should_not raise_error(Ruxu::CannotConnectToServer)
  end

  it 'should be raised upon invalid firefox binary' do
    lambda { setup(:binary => 'firefox-abc') }.
      should raise_error(Ruxu::CannotConnectToServer)
  end

  it 'should be raised upon invalid port number' do
    lambda { setup(:port => '99999') }.should
      raise_error(Ruxu::CannotConnectToServer)
  end

  it 'should be raised upon invalid host' do
    lambda { setup(:host => 'happy.man') }.should
      raise_error(Ruxu::CannotConnectToServer)
  end

  it 'should be raised upon invalid profile' do
    lambda { setup(:profile => 'happy') }.should
      raise_error(Ruxu::CannotConnectToServer)
  end

end
