module Refinery
  module Messages
    class Mailer < ActionMailer::Base

      def confirmation(message, request)
        @message = message
        mail :subject  => Refinery::Messages::Setting.confirmation_subject,
             :to       => message.email,
             :from     => "\"#{Refinery::Core.site_name}\" <no-reply@#{request.domain}>",
             :reply_to => Refinery::Messages::Setting.notification_recipients.split(',').first
      end

      def notification(message, request)
        @message = message
        mail :subject  => Refinery::Messages::Setting.notification_subject,
             :to       => Refinery::Messages::Setting.notification_recipients,
             :from     => "\"#{Refinery::Core.site_name}\" <no-reply@#{request.domain}>"
      end

    end
  end
end
