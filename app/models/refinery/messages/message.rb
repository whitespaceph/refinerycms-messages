module Refinery
  module Messages
    class Message < Refinery::Core::BaseModel
      self.table_name = 'refinery_messages'

      attr_accessible :name, :message, :position

      # Add some validation here if you want to validate the user's input
      # We have validated the first string field for you.
      validates :name, :presence => true
    end
  end
end
