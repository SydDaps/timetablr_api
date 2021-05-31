class ApplicationController < ActionController::API
    before_action :authenticate_request
    include ErrorHandler

    def authenticate_request
        @current_user = Auth::AuthorizeRequest.call(request.headers)
    end

    def current_time_table
        time_table = TimeTable.find(params[:time_table_id])
    end
    
end
