class NotificationJob < ApplicationJob

    queue_as :default

	def perform()

        today_schedules = TimeTable.find("ae1bd5da-31b1-4edf-b08a-460f5c3b05b6").time_tags.map{ |l| l.meet_times }.flatten
        today_schedules.each do |meet_time|

            
            if(Time.parse(meet_time.start.strftime("%H:%M:%S")).between?(Time.now, Time.now + 1.hours + 30.minutes))

                
                meet_time.pairings.each do |pairing|

                    
                        
                    if pairing.day.name ==  Date.today.strftime("%A")
                        puts "---------------------------------------------------"
                        puts "the Course #{ pairing.course.name } #{ pairing.meet_time.start } #{pairing.day.name} #{pairing.time_tag.name}"
                    end
                    

                    
                end
            end
        end
        

    end

end

# days.where(name: Date.today.strftime("%A"))