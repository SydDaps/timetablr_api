class NotificationJob < ApplicationJob

    queue_as :default

	def perform()

        
        TimeTable.all.where(is_published: true).each do |time_table|
            today_schedules = time_table.time_tags.map{ |l| l.meet_times }.flatten
            today_schedules.each do |meet_time|

                
                if(Time.parse(meet_time.start.strftime("%H:%M:%S")).between?(Time.parse("7:00"), Time.parse("7:30") + 30.minutes))

                    
                    meet_time.pairings.each do |pairing|

                        
                        
                        if $redis.get("pairing#{pairing.id}")
                            puts "---------------------------------------------------"
                            puts "Already printed"
                            next
                        end
                            
                        if pairing.day.name ==  "Thursday"
                            

                            # $redis.setex("pairing#{pairing.id}", pairing.time_tag.duration + 30.minutes, true)

                            

                            pairing.course.lecturers.each do |lecturer|
                                ActionCable.server.broadcast(
                                    "notify_#{lecturer.id}", 
                                    {
                                        message: "#{ pairing.course.name } starts at #{ pairing.meet_time.start }"
                                    }
                                )

                                puts "--------------------------------------------------- lecturer"
                                puts "#{ pairing.course.name } starts at #{ pairing.meet_time.start.strftime("%I:%M%p") }"
                                puts "#{ lecturer.email } lecturer get"
                            
                            end
0
                            time_table.students.each do |student|
                                level = student.level
                                department = student.department
                                if(level == pairing.course.level && department == pairing.course.department)
                                    ActionCable.server.broadcast(
                                        "notify_#{student.id}", 
                                        {
                                            message: "#{ pairing.course.name } starts at #{ pairing.meet_time.start.strftime("%I:%M%p") } don't be late"
                                        }
                                    )

                                    puts "--------------------------------------------------- student"
                                    puts "#{ pairing.course.name } starts at #{ pairing.meet_time.start.strftime("%I:%M%p") } don't be late"
                                    puts "#{ student.email} will get"
                                end
                            end
                        end            
                    end
                end
            end
        end
        

    end

end

# days.where(name: Date.today.strftime("%A"))