module Refinery
  module Messages
    class MessagesController < ::ApplicationController

      before_filter :find_page, :only => [:create, :new]

      def index
        redirect_to :action => "new"
      end

      def thank_you
        @page = Refinery::Page.find_by_link_url("/messages/thank_you", :include => [:parts])
      end

      def new
        @message = Message.new
      end

      def create
        @message = Message.new(params[:message])

        if @message.save
          begin
            Mailer.notification(@message, request).deliver
          rescue => e
            logger.warn "There was an error delivering the message notification.\n#{e.message}\n"
          end

          if Message.column_names.map(&:to_s).include?('email')
            begin
              Mailer.confirmation(@message, request).deliver
            rescue => e
              logger.warn "There was an error delivering the message confirmation:\n#{e.message}\n"
            end
          else
            logger.warn "Please add an 'email' field to Message if you wish to send confirmation emails when forms are submitted."
          end

          redirect_to refinery.thank_you_messages_messages_path
        else
          render :action => 'new'
        end
      end

    protected

      def find_page
        @page = Refinery::Page.find_by_link_url('/messages/new', :include => [:parts])
      end

    end
  end
end
