module ScheduleService
    class Scheduler < BaseService
        def initialize(params)
          @day =  params[:day]
          @courses = params[:courses]
          @meet_rooms = params[:meet_rooms]
          @time_table = params[:time_table]
        end

        def call
            Schedule.transaction  do
                days_schedules = {}
                @time_table.days.each do |day|
                    days_schedules[day.id] = []
                end
                

                @time_table.lecturers.each do |lecturer|
                    unless lecturer.lecture_schedules.empty?
                        
                        total = lecturer.lecture_schedules.count
                        lecturer_courses = []
                        lecturer.courses.where({time_table_id: @time_table.id}).each do |course|
                            course.time_tags.each{ |l| lecturer_courses.push([l.id, course])}
                        end
                        days_courses =  lecturer_courses.count / total.to_f 
                        lecturer_courses = lecturer_courses.shuffle.each_slice(days_courses.ceil).to_a
                        lecturer.lecture_schedules.each_with_index do |ls, i|
                            lecturer_courses[i].each do |lc|
                                days_schedules[ls.day.id].push(
                                    {time_tag: TimeTag.find(lc.first),course: lc.last}
                                )
                                @courses[lc.first].delete({time_tag: TimeTag.find(lc.first),course: lc.last})
                                
                            end
                        end
                    end
                end
                temp_meet_rooms = @meet_rooms

                

                
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   

                @time_table.days.each do |day|
                    schedule = @time_table.schedules.create!

                    lecturer_busy_time = {}
                    @time_table.lecturers.each do |lecturer|
                        lecturer_busy_time[lecturer.id] = []
                    end
                    
                    room_busy_times = {}
                    @time_table.rooms.each do |room|
                        room_busy_times[room.id] = []
                    end

                    class_busy_times = {}
                    @time_table.courses.each do |course|
                        class_busy_times[course.department.id + course.level.id] = []
                    end

                    
                    
                    @time_table.time_tags.each do |tag|
                        days_estimate = (tag.courses.count.to_f / @time_table.days.count).ceil + 2
                        counter = 0

                        # @meet_rooms = @meet_rooms.transform_values{ |v| v.shuffle }
                        @meet_rooms[tag.id].each do |temp_mr|

                            
                            here = false 
                            if counter == days_estimate
                                break
                            end
                            
                            temp_time = temp_mr[:meet_time]
                            temp_room = temp_mr[:room]
                            fit_course = nil


                            unless busy_constraint_satisfied?(room_busy_times[temp_room.id], temp_time)
                                next
                            end
                            

                            # share lecturer courses to days
                            # custom Schedule data structure
                           
                            
                            mr = nil
                            

                            @courses[tag.id].each  do |course|
                                lecturer_busy = false

                                if days_schedules[day.id].empty? == false
                               
                                    here = true
                                    
                                 
                                    # @courses[tag.id].insert(
                                    #     0,
                                    #     days_schedules[day.id][tag.id].first
                                    # )

                                    course = days_schedules[day.id].first
                                    mr = @meet_rooms[course[:time_tag].id].shuffle.first
                                    time = mr[:meet_time]
                                    room = mr[:room]
                                else
                                    mr = temp_mr
                                    time = temp_time
                                    room = temp_room
                                end

                                
                                
                                course[:course].lecturers.each do |lecturer|
                                    unless busy_constraint_satisfied?(lecturer_busy_time[lecturer.id], time)
                                        lecturer_busy = true
                                        break
                                    end
                                end

                                next if lecturer_busy
                                

                                class_busy = false

                                unless busy_constraint_satisfied?(class_busy_times[course[:course].department.id + course[:course].level.id], time, course[:course])
                                    class_busy = true
                                    break
                                end

                                next if class_busy

                                

                                
                                

                                
                                
                                fit_course = course

                                # Adding an hour break to each students class before next class
                                
                                scheduled_time = ScheduleTime.create(
                                    start: mr[:meet_time].start,
                                    end: mr[:meet_time].end
                                )
                                class_busy_times[course[:course].department.id + course[:course].level.id].push(
                                    {
                                        time: scheduled_time,
                                        course_kind: fit_course[:course].kind
                                    }
                                ) 
                                
                                course[:course].lecturers.each do |l|
                                    lecturer_busy_time[l.id] << {time: mr[:meet_time]}
                                end
                                
                                room_busy_times[room.id] << {time: mr[:meet_time]}
            
                                break
                            
                            end
                            
                            unless fit_course
                                next
                            else
                                
                                Pairing.create!(
                                    schedule_id: schedule.id,
                                    course_id: fit_course[:course].id,
                                    time_tag_id: fit_course[:time_tag].id,
                                    meet_time_id: mr[:meet_time].id,
                                    room_id: mr[:room].id,
                                    day_id: day.id
                                )
                                counter += 1
                               
                                @courses[tag.id].delete(fit_course)
                                
                                days_schedules[day.id].delete(fit_course)
                            end
                        end
                    end
                end                
            end

            total_pairings = 0
            @time_table.schedules.all.each do  |s| 
                s.calc_fitness 
                total_pairings += s.pairings.count
            end

            total_pairings
        end


        def busy_constraint_satisfied?(entity, time, type = nil)
            # an entity can be anything i am trying to track if busy or not busy
            # logic is to check if the time currently in the tracker ds clashes with the new incoming time



            entity.each do |t|
                start_at = (t[:time].start ).between?(time.start, time.end - 5)
                end_at = (t[:time].end - 5).between?(time.start, time.end)

                if start_at || end_at

                    if type.class == Course
                        if t[:course_kind] == "elective" && type.kind == "elective"
                           
                            elective_start = (time.start + 5).between?(t[:time].start, t[:time].end)
                            elective_end = (time.end - 5).between?(t[:time].start, t[:time].end)

                            if elective_start && elective_end
                                return true
                            end
                        end
                    end
             
                    return false
                end

            end

            return true
        end
    end
end