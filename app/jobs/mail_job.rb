class MailJob < ApplicationJob

    queue_as :default

	def perform(params)

    

        params[:emails].each do |email|
            params1 = {
                emails: email,
                time_table: params[:time_table],
                user: params[:user]
            }

            PublishMailer.new_timetable_mail(params1).deliver_now 

            puts "-------------"

        end

        params[:time_table].update(is_published: true)
    end

end
