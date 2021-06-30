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
                @time_table.class_time_trackers.destroy_all
                @time_table.lecturer_time_trackers.destroy_all
                @time_table.room_time_trackers.destroy_all

                days_schedules = {}
                @time_table.days.each do |day|
                    days_schedules[day.id] = {}
                    @time_table.time_tags.each do |tag|
                        days_schedules[day.id][tag.id] = []
                    end
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
                                days_schedules[ls.day.id][lc.first].push(
                                    {time_tag: TimeTag.find(lc.first),course: lc.last}
                                )
                                @courses[lc.first].delete({time_tag: TimeTag.find(lc.first),course: lc.last})
                                
                            end
                        end
                    end
                end
                
                

                days_schedules.each do |ds|
                    
                    @day = Day.find(ds.first)


                    @time_table.time_tags.each do |tag|
                        
                        if days_schedules[@day.id][tag.id].empty?
                            next
                        end

                        @schedule =  @time_table.schedules.joins(:pairings).where(pairings: {day_id: @day.id}).first || @time_table.schedules.create!  
                        @meet_rooms = @meet_rooms.transform_values{ |v| v.shuffle }
                        @meet_rooms[tag.id].each do |mr|
                            @mr = mr
                            @time = mr[:meet_time]
                            @room = mr[:room]

                            


                            days_schedules[@day.id][tag.id].each do |course|
                                @course = course 
                                constraints = check_constraints()
                                if constraints == "class_busy"
                                   
                                    next
                                elsif constraints == "lecturer_busy"
                                    
                                    next
                                elsif constraints == "room_busy"
                                    
                                    next
                                end
                                
                                
                                add_pairing()
                                

                                days_schedules[@day.id][tag.id].delete(course)

                                break
        
                            end
                        end
                    end
                    
                    
                end
                
                
             
                
                
               
                
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   

                @time_table.days.each do |day|
                    @day = day
                    @schedule =  @time_table.schedules.joins(:pairings).where(pairings: {day_id: @day.id}).first || @time_table.schedules.create!        
                    
                    @time_table.time_tags.order(duration: :desc).each do |tag|
                        @tag = tag
                        
                        days_estimate = (@tag.courses.count.to_f / (@time_table.days.count)).ceil
                        counter = 0
                        
                        @meet_rooms[tag.id].each do |mr|
                           
                            
                            
                            if counter == days_estimate
                                    
                                break
                            end
                            
                            @mr = mr
                            @time = mr[:meet_time]
                            @room = mr[:room]
                            
                            @courses[tag.id].each  do |course|

                                if counter == days_estimate
                                    
                                    break
                                end

                                @course = course
                                

                                constraints = check_constraints()
                                if constraints == "class_busy" || constraints == "lecturer_busy"
                                  
                                    next
                                elsif constraints == "room_busy"
                                    
                                    break
                                end
                                
                                

                                add_pairing()

                                counter += 1

                                
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


        def busy_constraint_satisfied?(entity, type = nil)
            
            entity.each do |t|
                start_at = (t.schedule_time.start ).between?(@time.start, @time.end - 5)
                end_at = (t.schedule_time.end - 5).between?(@time.start, @time.end)
                start2 = (@time.start ).between?(t.schedule_time.start, t.schedule_time.end - 5)
                end2 = (@time.start ).between?(t.schedule_time.start, t.schedule_time.end - 5)

                if start_at || end_at || start2 || end2

                    if type.class == Course
                        if t.course_kind == "elective" && type.kind == "elective"

                            elective_start = (@time.start ).between?(t.schedule_time.start, t.schedule_time.end - 5)
                            elective_end = (@time.start ).between?(t.schedule_time.start, t.schedule_time.end - 5)

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


        def  check_constraints()
            @course[:course].lecturers.each do |lecturer|
                unless busy_constraint_satisfied?(@time_table.lecturer_time_trackers.where(lecturer_id: lecturer.id, day_id: @day.id))
                    return "lecturer_busy"
                end
            end

            unless busy_constraint_satisfied?(@time_table.room_time_trackers.where(room_id: @room.id, day_id: @day.id))
                
                return "room_busy"
            end

            unless busy_constraint_satisfied?(@time_table.class_time_trackers.where(level_id: @course[:course].level.id, department_id: @course[:course].department.id, day_id: @day.id ), @course[:course])
                return "class_busy"
            end

            true
        end


        def add_pairing()
            scheduled_time = ScheduleTime.create(
                start: @mr[:meet_time].start,
                end: @mr[:meet_time].end
            )

            ClassTimeTracker.create!(
                level: @course[:course].level,
                department: @course[:course].department,
                course_kind: @course[:course].kind,
                day: @day,
                time_table: @time_table,
                schedule_time: scheduled_time
            )

            @course[:course].lecturers.each do |l|
                LecturerTimeTracker.create!(
                    lecturer: l, 
                    day: @day,
                    time_table: @time_table,
                    schedule_time: scheduled_time
                )
            end
            
            RoomTimeTracker.create!(
                room: @room,
                day: @day,
                time_table: @time_table,
                schedule_time: scheduled_time
            )
         
            Pairing.create!(
                schedule_id: @schedule.id,
                course_id: @course[:course].id,
                time_tag_id: @course[:time_tag].id,
                meet_time_id: @mr[:meet_time].id,
                room_id: @mr[:room].id,
                day_id: @day.id
            )
            
            if @tag
                @courses[@tag.id].delete(@course)
            end

            
            
            
                
            
        end
    end
end