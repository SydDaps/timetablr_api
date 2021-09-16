class PublishMailer < ApplicationMailer
    def new_timetable_mail(params)

        @emails = params[:emails]
        @time_table = params[:time_table]
        @current_user = params[:user]

        mail(to: @emails, subject: "New Timetable out!")
    end
end
