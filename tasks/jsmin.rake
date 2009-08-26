# Adapted from http://maintainable.com/articles/minifying_your_rails_javascript

namespace :js do
  desc "Concatenate & minify javascript helpers"
  task :min do
    dir = File.join(File.dirname(File.expand_path(__FILE__)), '..', 'lib', 'ruxu', 'js')
    libs = %w{uuid.js ruxu.js}.map{|f| File.join(dir, f) }

    # paths to jsmin script and final minified file
    jsmin = File.join(dir, 'jsmin.rb')
    final = File.join(dir, 'minified.js')

    # create single tmp js file
    all_tmp, min_tmp = %w(all min).map {|n| Tempfile.open(n) }
    libs.each {|lib| open(lib) {|f| all_tmp.write(f.read) } }
    all_tmp.rewind

    # minify file
    %x[ruby #{jsmin} < #{all_tmp.path} > #{min_tmp.path}]
    File.open(final,'w') do |fh| 
      min_tmp.each {|l| fh << (l.strip) }
    end
  end
end
