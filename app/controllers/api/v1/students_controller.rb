class Api::V1::StudentsController < ApplicationController
  def create

    response = StudentService::Create.call(params.merge(time_table: current_time_table))

    render json: {
      success: true,
      code: 200,
      data: {
        students: StudentSerializer.new( current_time_table.students  ).serialize
      }
  }
    
  end
end
