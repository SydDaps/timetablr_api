module LecturerService
    class Create < BaseService
        def initialize(params)
          @name = params[:name]
          @email = params[:email]
          @time_table = params[:time_table]
        end

        def  call
            lecturer = Lecturer.find_by_email(@email)
            
            unless lecturer
                lecturer = Lecturer.create!(
                    name: @name,
                    email: @email,
                    password: "0000"
                )
            end

            unless @time_table.lecturers.find_by_id(lecturer.id)
                @time_table.lecturers << lecturer
            end

            
        end

        
        

    end
end 