module LevelService
    class Create < BaseService
        def initialize(params)
            @code = params[:code]
            @time_table = params[:time_table]
        end

        def call 
            level = @time_table.levels.create!(
                code: @code
            )
        end
    end
end