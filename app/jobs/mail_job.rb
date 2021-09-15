class MailJob < ApplicationJob

    queue_as :default

	def perform(params)

        

        emails = params[:emails].each_slice(5).to_a

        ["sydneyyork139@gmail.com","rayetey001@st.ug.edu.gh"].each do |email|
            params1 = {
                emails: email,
                time_table: params[:time_table]
            }

            PublishMailer.new_timetable_mail(params1).deliver_now 

        end

        params[:time_table].update(is_published: true)
    end

end