require 'rufus-scheduler'
class Maid::Repeat
  include Maid::RuleContainer
  
  attr_reader :timestring, :scheduler, :logger
  
  def initialize(maid, timestring, &rules)
    @maid = maid
    @logger = maid.logger # TODO: Maybe it's better to create seperate loggers?
    @scheduler = Rufus::Scheduler.singleton
    @timestring = timestring
    initialize_rules(&rules)
  end

  def run
    unless rules.empty?
      @scheduler.repeat(timestring) { follow_rules }
    end
  end
  
  def stop
    @scheduler.shutdown
  end
end