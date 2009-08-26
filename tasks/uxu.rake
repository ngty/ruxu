namespace :uxu do

  desc 'Start uxu server with firefox-3.5'
  task :ff35 do
    sh 'firefox-3.5 -no-remote -P UxU'
  end

  desc 'Start uxu server with firefox-3.0'
  task :ff30 do
    sh 'firefox-3.0 -no-remote -P UxU'
  end

end
