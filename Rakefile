require 'html-proofer'

task :test do
    sh "pip install --user -r _nginx/requirements.txt"
    sh "python _nginx/generate.py"
    sh "./_nginx/test-config.sh"
    sh "bundle exec jekyll build"
    HTMLProofer.check_directory("./_site", {:parallel => { :in_processes => 3}, :disable_external => false, :assume_extension => true, :only_4xx => true}).run()
end
