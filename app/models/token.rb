require 'user_agent_parser'

class Token < ApplicationRecord
  belongs_to :user, counter_cache: true

  def user_agent=(ua)
    parsed_agent = UserAgentParser.parse(ua)

    self.device = parsed_agent.device.family
    self.os = parsed_agent.os.to_s
    self.browser = parsed_agent.family
    self.browser_version = parsed_agent.version.to_s
  end
end
