class Schedule < ApplicationRecord
    has_many :courses, through: :pairings
	has_many :rooms, through: :pairings
    has_many :lecturers, through: :pairings
    has_many :meet_times, through: :pairings
    has_many :days, through: :pairings
    has_many :time_tags, through: :pairings

    belongs_to :time_table

    has_many :pairings, dependent: :destroy



    def calc_fitness
        conflicts = 0
        pairings = self.pairings
        
        pairings.each_with_index do |pairing, current_index|
            meet_time = pairing.meet_time
            (current_index..pairings.length - 1).each do |index|
                current_pairing = pairings[index]
                next if pairing.id == current_pairing.id

                start_at = (meet_time.start).between?(current_pairing.meet_time.start, current_pairing.meet_time.end - 5.minutes)
                end_at = (meet_time.end - 5.minutes).between?(current_pairing.meet_time.start, current_pairing.meet_time.end)
                start_1 = (current_pairing.meet_time.start).between?(meet_time.start, meet_time.end - 5.minutes)
                end_1 = (current_pairing.meet_time.end - 5.minutes).between?(meet_time.start, meet_time.end)

                if start_at || end_at || start_1 || end_1
                    
                    if pairing.room.id == current_pairing.room.id
                        puts pairing.room.name
                        puts current_pairing.room.name
                        puts "room ----------------- conflict"
                        puts "room ----------------- conflict"
                        puts "room ----------------- conflict"

                        conflicts += 1
                    end

                    pairing.course.lecturers.each do |lecturer|
                        
                        if current_pairing.course.lecturers.find_by_id(lecturer.id)

                            conflicts += 1
                            
                            puts "lecturer ----------------- conflict"
                            puts "lecturer ----------------- conflict"
                            puts "lecturer ----------------- conflict"

                        end
                    end
                    

                    
                    same_department = pairing.course.department == current_pairing.course.department
                    general_department_pairing = pairing.course.department.name.downcase  == "general"
                    general_department_current = current_pairing.course.department.name.downcase  == "general"
                    if same_department || general_department_pairing || general_department_current
                        if pairing.course.level == current_pairing.course.level
                            unless pairing.course.kind == "elective" &&  current_pairing.course.kind == "elective"

                                byebug 

                                puts "level --- conflicts"
                                puts "level --- conflicts"
                                puts "level --- conflicts"
                                puts "level --- conflicts"
                                conflicts += 1
                            end
                        end
                    end
                end

            end 
        end

        
    
        fitness = (1 / (1 + conflicts).to_f).round(2)
        self.update(conflicts: conflicts, fitness: fitness)
    end
end
