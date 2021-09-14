class Api::V1::PublisherController < ApplicationController

    def send
        
        students = current_time_table.students
        lectures = current_time_table.lecturers

        
    end
end
