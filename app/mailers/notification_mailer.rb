class NotificationMailer < ApplicationMailer

    default from: "no-reply@kelpapp.com"

    def comment_added
         mail(to: "gnazarian7@gmail.com",
         subject: "A comment has been added to your place")
    end

end
