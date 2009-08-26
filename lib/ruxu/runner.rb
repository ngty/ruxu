module Ruxu

  class Runner

    extend Forwardable

    def_delegators :@connection, :send, :read, :close

    def initialize(options={})
      @server = Server.new(options)
      @connection = Connection.new(options.merge(:server => @server))
      @connection.start
    end

  end

end
