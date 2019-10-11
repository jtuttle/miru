require "miru/version"

module Miru
  begin
    require 'pry-byebug'
  rescue LoadError
    # development dependencies
  end
    
  require 'set'

  Gem.find_files("miru/**/*.rb").each { |path| require path }
end
