module TimeTableService
    class Create < BaseService
        def initialize(time_table_params, current_user)
            @name = time_table_params[:name]
            @kind = time_table_params[:kind]
            @category = time_table_params[:category]
            @user_id = current_user.id
        end

        def call
            time_table = TimeTable.create!(
                name: @name,
                kind: @kind,
                category: @category,
                user_id: @user_id,
                status: "pending"
            )

            time_table
        end
    end
end