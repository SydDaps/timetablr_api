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

                @time_table.days.each do |day|

                    schedule = @time_table.schedules.create!

                    lecturer_busy_time = {}
                    @time_table.lecturers.each do |lecturer|
                        lecturer_busy_time[lecturer.id] = []
                    end

                    class_busy_times = {}
                    @time_table.courses.each do |course|
                        class_busy_times[course.department.code + course.level.code] = []
                    end

                    
                    
                    @time_table.time_tags.all.each do |tag|
                        days_estimate = (tag.courses.count.to_f / @time_table.days.count).ceil
                        counter = 0

                        @meet_rooms = @meet_rooms.transform_values{ |v| v.shuffle }
                        @meet_rooms[tag.id].each do |mr|

                            if counter == days_estimate
                                break
                            end
                            
                            time = mr[:meet_time]
                            room = mr[:room]
                            c_course = nil
                            

                            @courses[tag.id].each  do |course|
                                tester = true
                                
                                course[:course].lecturers.each do |lecturer|
                                    lecturer_busy_time[lecturer.id].each do |t|
                                        start_at = (time.start ).between?(t.start, t.end - 5)
                                        end_at = (time.end - 5).between?(t.start, t.end)

                                        if start_at || end_at
                                            tester = false
                                            break
                                        end
                                    end

                                    unless tester
                                        break
                                    end
                                end

                                unless tester
                                    next
                                end

                                class_busy_times[course[:course].department.code + course[:course].level.code].each do |t|
                                    start_at = (time.start ).between?(t.start, t.end - 5)
                                    end_at = (time.end - 5).between?(t.start, t.end)

                                    if start_at || end_at
                                        tester = false
                                        break
                                    end

                                end

                                
                                unless tester
                                    next
                                end

                                if tester
                                    c_course = course
                                    class_busy_times[course[:course].department.code + course[:course].level.code] << mr[:meet_time]
                                    
                                    course[:course].lecturers.each do |l|
                                        lecturer_busy_time[l.id] << mr[:meet_time]
                                    end

                                    break
                                end
                            end
                            
                            unless c_course
                                next
                            else
                                
                                Pairing.create!(
                                    schedule_id: schedule.id,
                                    course_id: c_course[:course].id,
                                    time_tag_id: c_course[:time_tag].id,
                                    meet_time_id: mr[:meet_time].id,
                                    room_id: mr[:room].id,
                                    day_id: day.id
                                )
                                counter += 1
                                @courses[tag.id].delete(c_course)
                            end
                        end
                    end
                end                
            end

            @time_table.schedules.all.each{ |s| s.calc_fitness }
        end
    end
end