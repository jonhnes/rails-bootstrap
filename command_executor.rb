# frozen_string_literal: true

class CommandExecutor
  attr_accessor :config

  def initialize(config)
    @config = config
  end

  def install_rails
    final_command "gem install rails -v '#{@config.rails_version}'"
  end

  def create_rails_app
    app_dir = Dir.home + '/' + @config.app_name
    final_command "rails _#{@config.rails_version}_ new -B -T #{app_dir}"
  end

  private

  def rvm_use_command
    "rvm use #{@config.ruby_version}@#{@config.app_name} --create"
  end

  def final_command(main_command)
    commands = [rvm_use_command, main_command].join(' && ')
    system 'bash', '-lc', commands
  end
end
