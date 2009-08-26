module Ruxu
  class Server

    def initialize(args)
      @binary  = args[:binary]  || binary_path
      @profile = args[:profile] || 'UxU'
    end

    def start
      @thread = Thread.new { system %\#{@binary} -no-remote -P #{@profile}\ }
      sleep 2
    end

    private

      def binary_path
        # Don't ask me how i do this part, i just copy-and-paste from
        # firewatir :]
        case RUBY_PLATFORM
          when /mswin/
            require 'win32/registry.rb'
            bin_path = ""
            Win32::Registry::HKEY_LOCAL_MACHINE.open('SOFTWARE\Mozilla\Mozilla Firefox') do |reg|
              keys = reg.keys
              reg1 = Win32::Registry::HKEY_LOCAL_MACHINE.open("SOFTWARE\\Mozilla\\Mozilla Firefox\\#{keys[0]}\\Main")
              reg1.each do |subkey, type, data|
                if(subkey =~ /pathtoexe/i)
                  bin_path = data
                end
              end
            end
            bin_path

          when /linux/i
            `which firefox`.strip
          when /darwin/i
            '/Applications/Firefox.app/Contents/MacOS/firefox'
          when /java/
            raise "Not implemented: Create a browser finder in JRuby"
        end
      end
  end

end
