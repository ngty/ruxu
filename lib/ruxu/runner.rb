module Ruxu

  class Runner

    extend Forwardable

    def_delegators :@connection, :send, :read, :close, :close_all

    def initialize(options={})
      @server = Server.new(options)
      @connection = Connection.new(options.merge(:server => @server))
      @connection.start
    end

    def open_page(location)
      send(%\ruxu.open_page("#{location}")\)
      sleep 0.5
      if send('ruxu.page.document.title') =~ /Problem loading page/
        raise CannotOpenDocumentError
      end
    end

  end

end
