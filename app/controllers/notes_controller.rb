class NotesController < InheritedResources::Base
	
	def new		

	end

	def create		
		p params[:parent_id]

		@parent = get_parent(params)
		@note = Note.new(note_params)		
		@note.comment_by = current_user.id	
		@note.inquiry_id = params[:inquiry_id]


		respond_to do |format|
				if @note.save					
						format.html { redirect_to @parent, notice: "note added successfully to leads id #{params[:inquiry_id]}!" }
				        format.json { head :ok }			    					        
				else				
					format.html { render @parent }
				    format.json { render json: @note.errors, status: :unprocessable_entity }
				end
		end

	end


	# def update

	# 	p params[:parent_id]
		
	# 	@note = note.find_by_id(params[:id])
	# 	@parent = get_parent(params)


	# 	respond_to do |format|
	# 			if @note.update(note_params)					
	# 					format.html { redirect_to @parent, notice: "note was successfuly updated to leads id #{params[:inquiry_id]}!" }
	# 		        	format.json {head :ok }			    				        	
	# 			else				
	# 				format.html { render @parent }
	# 		        format.json { render json: @note.errors, status: :unprocessable_entity }
	# 			end
	# 	end

	# end

  private

    def note_params
      params.require(:note).permit(:comment_by, :note, :inquiry_id)
    end

    def get_parent(params)    	
    	if params[:parent_id]
    		return userpage_path(:slug => User.where(:id => params[:parent_id]).slug)	
    	else
    		return root_path
    	end		
    end
end

