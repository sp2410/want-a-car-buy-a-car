class ActivityLoggersController < InheritedResources::Base

	def create
		begin
			NewLogCreator.perform_async(activity_logger_params)							
		rescue

		end
	end


  private

    def activity_logger_params
      params.require(:activity_logger).permit(:contact, :activity, :type)
    end
end



