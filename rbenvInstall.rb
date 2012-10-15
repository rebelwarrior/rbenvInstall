
def install_rbenv
  # %x[rvm implode] if rvm? 
  # Dir.chdir(Dir.home)
  Dir.chdir(File.expand_path('~'))
  Dir.mkdir('.rbenv')
  %x[git clone git://github.com/sstephenson/rbenv.git .rbenv]
  puts "Configuring .bash_profile"
  %x[echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile] #add to PATH
  %x[echo 'eval "$(rbenv init -)"' >> ~/.bash_profile] #add to shims for autocompletion
  %x[exec $SHELL]
  puts "Installing ruby-build as a plugin for rbenv."
  Dir.chdir('.rbenv')
  Dir.mkdir('plugins')
  Dir.chdir('plugins')
  %x[git clone git://github.com/sstephenson/ruby-build.git] #get ruby-build
  Dir.chdir('..')
  puts "Installing ruby 1.9.3-p194."
  %x[./bin/rbenv install 1.9.3-p194] #install ruby 1.9.3
  %x[./bin/rbenv rehash]
  puts "'rbenv install --list' will list all known rubies available to install."
  puts "You'll probably need to restart..."
end

install_rbenv()

def update_rbenv
  Dir.chdir(File.expand_path('~'))
  Dir.chdir('.rbenv')
  %x[git pull]
end

def update_ruby_build
  'pending'
end