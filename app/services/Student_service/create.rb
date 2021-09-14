module StudentService
    class Create < BaseService

        def initialize(params)
            @level_id = params[:level_id]
            @department_id = params[:department_id]
            @students = params[:students]
            @time_table = params[:time_table]

        end

        def call
            @students.each do |details|
                student = Student.find_by_email(details[:email])
                
                unless student
                    puts "come here ppppp"
                    student = Student.create(
                        level_id: @level_id,
                        department_id: @department_id,
                        email: details[:email],
                        name: details[:name]
                    )
                end

                unless student.time_tables.find_by(id: @time_table.id)
                    student.time_tables << @time_table
                end
            end

        end

    end
end