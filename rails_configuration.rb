# frozen_string_literal: true

class RailsConfiguration
  attr_accessor :app_name, :ruby_version, :rails_version

  def initialize
    @app_name = 'rails_bootstrap_app'
    @ruby_version = '2.6.4'
    @rails_version = '5.2.1'
  end
end
