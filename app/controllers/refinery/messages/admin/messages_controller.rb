module Refinery
  module Messages
    module Admin
      class MessagesController < Refinery::AdminController

        crudify :'refinery/messages/message', 
                :title_attribute => "name", 
                :order => "created_at DESC"

        def index
          unless searching?
            find_all_messages
          else
            search_all_messages
          end

          @grouped_messages = group_by_date(@messages)
        end

      end
    end
  end
end
