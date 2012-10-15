require 'FileUtils'

def install_rbenv(home=File.expand_path('~'), default=true)
  # %x[rvm implode] if rvm? 
  # Dir.chdir(Dir.home)
  puts '###### Installing rbenv.'
  Dir.chdir(home)
  Dir.mkdir('.rbenv')
  %x[git clone git://github.com/sstephenson/rbenv.git .rbenv]
  puts '###### Configuring .bash_profile'
  FileUtils.touch('./.bash_profile') 
  %x[echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ./.bash_profile] #add to PATH
  %x[echo 'eval "$(rbenv init -)"' >> ./.bash_profile] #add to shims for autocompletion
  %x[exec $SHELL] if default
  puts '###### Installing ruby-build as a plugin for rbenv.'
  Dir.chdir('.rbenv')
  Dir.mkdir('plugins')
  Dir.chdir('plugins')
  %x[git clone git://github.com/sstephenson/ruby-build.git] #get ruby-build
  Dir.chdir('..')
  puts '###### Installing ruby 1.9.3-p194.' 
  %x[./bin/rbenv install 1.9.3-p194] if default #install ruby 1.9.3
  %x[./bin/rbenv rehash] if default
  puts "'rbenv install --list' will list all known rubies available to install."
  puts "You'll probably need to restart..."
end

def update_rbenv(home=File.expand_path('~'))
  Dir.chdir(home)
  Dir.chdir('.rbenv')
  puts Dir.pwd
  %x[git pull]
  puts $?
end

def update_ruby_build(home=File.expand_path('~'))
  Dir.chdir(home)
  Dir.chdir('.rbenv/plugins')
  puts Dir.pwd
  %x[git pull]
  puts $?
end

#install_rbenv('C:/Sites/testrbenv', false)