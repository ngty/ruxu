module Ruxu

  class Connection

    def initialize(args)
      @server = args[:server]
      @host   = args[:host] || 'localhost'
      @port   = args[:port] || '4444'
    end

    def start
      no_of_tries, max_tries = 0, 5
      begin
        @socket = TCPSocket::new(@host, @port)
        @socket.sync = true
        send(javascript_utils_setup)
      rescue
        @server.start if no_of_tries < 1
        no_of_tries += 1
        retry if no_of_tries < max_tries
        raise CannotConnectToServerError
      end
    end

    def close
      send('window.opener.close()')
      @socket.close
      sleep 0.5
    end

    def send(cmd)
      @socket.puts(@last_cmd = cmd.strip)
      read
    end

    def read(size=4096)
      output = ""
      while IO.select([@socket], [], [], 0.05)
        break if @socket.eof?
        output << @socket.readpartial(size)
      end
      output.strip!
      if output =~ /^[A-Z]\w+Error: /
        raise JavascriptRuntimeError, [ output, %\Last Cmd: #{@last_cmd}\ ].join(" ; ")
      end
      output
    end

    private

      def javascript_utils_setup
        @js_utils_cmd ||=
          begin
            file = File.join(File.expand_path(File.dirname(__FILE__)), 'js', 'minified.js')
            File.open(file, 'r').readlines.join('')
          end
      end

  end

end
