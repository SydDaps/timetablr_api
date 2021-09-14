class PublishMailer < ApplicationMailer
    def new_timetable_mail(params)

        @emails = params[:emails]
        @time_table = params[:time_table]

        mail(to: @emails, subject: @time_table.user.name)
    end
end
