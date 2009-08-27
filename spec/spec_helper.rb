begin
  require 'spec'
rescue LoadError
  require 'rubygems' unless ENV['NO_RUBYGEMS']
  gem 'rspec'
  require 'spec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'ruxu'

describe 'standard setup', :shared => true do

  before(:all) do
    @runner = Ruxu::Runner.new(
      :host => 'localhost', :port => '4444',
      :binary => 'firefox-3.5', :profile => 'UxU'
    )
  end

  after(:all) do
    @runner.close_all
  end

end
