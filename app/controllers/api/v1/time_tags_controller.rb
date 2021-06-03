class Api::V1::TimeTagsController < ApplicationController
    before_action :check_params, only: [:create]

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
              time_tags: TimeTagSerializer.new( current_time_table.time_tags ).serialize
            }
        }
    end




    private
    def check_params
        if params[:time_tags].blank?
            raise Exceptions::MissingParam, "check Param"
        end

        params[:time_tags].each do |time_tag|
            if time_tag[:name].blank? || time_tag[:duration].blank?
                raise Exceptions::MissingParam, "Provide all duration, names and rooms for time tags"
            end
        end


    end
end
