require 'fileutils'

def install_rbenv(home=File.expand_path('~'), default=true)
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

def update(home=File.expand_path('~'))
  update_rbenv(home)
  update_ruby_build(home)
end

def rvm_installed?
  location = `which rvm`
  dotrvm = File.exists?('.rvm')
  !location.empty? || dotrvm
end

if $0 == __FILE__
  abort("Note: rvm is incompatible w/ rbenv. Uninstall rvm first.") if rvm_installed?
  options = ARGV
  case options[0]
  when /*-i*/
    install_rbenv()
  when /*-u*/
    update()
  when /*-test*/
    install_rbenv('C:/Sites/testrbenv', false)
  when /*-h*/
	puts "Help file pending. Update '-u' Install '-i'"
  else
	install_rbenv('C:/Sites/testrbenv', false)
  end

end
