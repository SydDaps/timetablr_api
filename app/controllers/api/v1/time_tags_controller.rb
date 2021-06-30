class Api::V1::TimeTagsController < ApplicationController
    

    def create
        time_tags = []

        TimeTag.transaction do
            params[:time_tags].each do |time_tag|
                time_tags << TimeTagService::Create.call(time_tag.merge(time_table: current_time_table))
            end
        end

        render json: {
            success: true,
            code: 200,
            data: {
              time_tags: TimeTagSerializer.new( time_tags ).serialize
            }
        }
    end

    def index
        render json: {
            success: true,
            code: 200,
            data: {
              time_tags: TimeTagSerializer.new( current_time_table.time_tags.order("name")).serialize
            }
        }
    end

    def update
        time_tag = TimeTag.find(params[:id])
        if params[:duration]
            duration = params[:duration] = params[:duration].first.hours + params[:duration].second.minutes
        end
        current_time_table.schedules.destroy_all
        current_time_table.update!(status: "pending")
       
        time_tag.meet_times.destroy_all
        time_tag.update!(update_params.merge(duration: duration))
        
        time_tag.set_meet_times
  
        render json: {
            success: true,
            code: 200,
            data: {
              time_tags: TimeTagSerializer.new( current_time_table.time_tags ).serialize
            },
        }
    end
  
    def destroy
      current_time_table.schedules.destroy_all
      current_time_table.update!(status: "pending")
      TimeTag.destroy(params[:id])
  
      render json: {
        success: true,
        code: 200,
        data: {
          time_tags: TimeTagSerializer.new( current_time_table.time_tags ).serialize
        },
      }
    end

    private

    def update_params
        params.permit(:name)
    end

    
end
