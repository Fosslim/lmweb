module Logging
  # This is the magical bit that gets mixed into your classes
  def logger
    Logging.logger
  end

  def log
     @logger ||= Logging.logger
  end
  # Global, memoized, lazy initialized instance of a logger
  def self.logger
    @logger ||= Logger.new(STDOUT)
  end

  def self.log
     @logger ||= Logging.logger
  end
end


#TODO remove it
# was just quick work around by pass forgotten logger inte gem;
module LicenseMatcher
	class RuleMatcher 
		include Logging
	end
end
