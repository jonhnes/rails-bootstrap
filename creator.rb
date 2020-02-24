# frozen_string_literal: true

require './rails_configuration'
require './command_executor'

class Creator
  attr_accessor :config

  def initialize
    @config = RailsConfiguration.new
    @exec = CommandExecutor.new @config
  end

  def create_app
    verify_rvm_installation
    gets_app_name
    gets_ruby_version
    gets_rails_version
    install_rails
    create_rails_app
  end

  def verify_rvm_installation
    puts 'Verifying rvm...'
    rvm_command = `rvm`
    if rvm_command.include?('Ruby enVironment Manager')
      puts 'rvm instaled'
    else
      puts 'Please, install rvm'
    end
  end

  def gets_app_name
    puts "What's your app name?"
    loop do
      app_name = gets.strip
      @config.app_name = app_name
      break unless app_name.empty?

      puts 'Please, insert a valid name'
    end
  end

  def gets_ruby_version
    puts "What's the ruby version?"
    loop do
      ruby_version = gets.strip
      @config.ruby_version = ruby_version
      break unless ruby_version.empty?

      puts 'Please, insert a valid ruby version'
    end
  end

  def gets_rails_version
    puts "What's the rails version?"
    loop do
      rails_version = gets.strip
      @config.rails_version = rails_version
      break unless rails_version.empty?

      puts 'Please, insert a valid rails version'
    end
  end

  def install_rails
    @exec.install_rails
  end

  def create_rails_app
    @exec.create_rails_app
  end
end
