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
    final_command "rails _#{@config.rails_version}_ new -B -T -d postgresql "\
                  "--skip-turbolinks --skip-gemfile #{app_dir}"
  end

  def copy_gemfile
    default_gemfile_path = "#{Dir.pwd}/assets/Gemfile"
    new_gemfile_path = "#{Dir.home}/#{@config.app_name}/Gemfile"
    text = File.read(default_gemfile_path)
    new_contents = text.gsub(/__ruby_version__/, @config.ruby_version)
                       .gsub(/__rails_version__/, @config.rails_version)
    puts new_contents
    File.open(new_gemfile_path, 'w') { |file| file.puts new_contents }
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
