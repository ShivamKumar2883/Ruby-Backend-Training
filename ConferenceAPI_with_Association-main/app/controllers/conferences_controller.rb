class ConferencesController < ApplicationController

    before_action :authenticate_user, except: [:show, :index]

    def index
        @conferences = Conference.all
        # respond_to :json
        render json: @conferences, status: :ok
    end

    def show
        begin
            @conference = Conference.find_by(id: params[:id])
            render json: @conference
        rescue ActiveRecord::RecordNotFound
            render json: { error: "Conference with ID #{params[:id]} not found." }
        end
    end

    def create
        begin
            @conference = Conference.new(conference_params)
            @conference.j_user = JUser.find_by(id: params[:j_user_id])

            case @conference.conference_mode_id.to_i
            when 1
            
            when 2
                @conference.event_url = nil
                 build_location_association(params[:conference][:location])

            when 3
                build_location_association(params[:conference][:location])
            end
            
            if @conference.save
                if params[:conference_categories].present?
                params[:conference_categories].each do |category_data|
                     ConferenceCategory.create!(
                     name: category_data[:name],
                     conferences_id: @conference.id
                    )
                end
            end
                render json: @conference.as_json(include: :conference_categories), status: :created
            else
                render json: { error: "Validation failed", details: @conference.errors.full_messages }, status: :unprocessable_entity
            end
        rescue => e
            render json: { error: "Creation failed", details: e.message }, status: :internal_server_error
        end
    end

    def update
  begin
    @conference = Conference.find(params[:id])
    
    @conference.title = params[:conference][:title] if params[:conference][:title].present?
    @conference.description = params[:conference][:description] if params[:conference][:description].present?
    @conference.theme = params[:conference][:theme] if params[:conference][:theme].present?
    @conference.start_date = params[:conference][:start_date] if params[:conference][:start_date].present?
    @conference.end_date = params[:conference][:end_date] if params[:conference][:end_date].present?
    @conference.image = params[:conference][:image] if params[:conference][:image].present?
    @conference.status = params[:conference][:status] if params[:conference][:status].present?
    @conference.event_url = params[:conference][:event_url] if params[:conference][:event_url].present?
    @conference.badges_id = params[:conference][:badges_id] if params[:conference][:badges_id].present?
    @conference.conference_mode_id = params[:conference][:conference_mode_id] if params[:conference][:conference_mode_id].present?
    
    if @conference.conference_mode_id.to_i == 2
      @conference.event_url = nil
    end
    
    if @conference.save
      if params[:conference][:location].present? && [2, 3].include?(@conference.conference_mode_id.to_i)
        @conference.locations.destroy_all
        build_location_association(params[:conference][:location])
      end
      
      if params[:conference_categories].present?
        @conference.conference_categories.destroy_all
        params[:conference_categories].each do |category_data|
          ConferenceCategory.create(
            name: category_data[:name],
            conferences_id: @conference.id
          )
        end
      end
      
      render json: @conference.as_json(include: [:conference_categories, :locations]), status: :ok
    else
      render json: { error: "Validation failed", details: @conference.errors.full_messages }, status: :unprocessable_entity
    end
    
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Conference with ID #{params[:id]} not found." }, status: :not_found
  rescue => e
    render json: { error: "Update failed", details: e.message }, status: :internal_server_error
  end
end

    def destroy
        begin
            @conference = Conference.find(params[:id])
            if @conference.destroy
                render json: { message: "Conference deleted successfully" }, status: :ok
            else
                render json: { error: "Deletion failed", details: @conference.errors.full_messages }, status: :unprocessable_entity
            end
        rescue ActiveRecord::RecordNotFound
            render json: { error: "Conference with ID #{params[:id]} not found." }, status: :not_found
        rescue => e
            render json: { error: "Deletion failed", details: e.message }, status: :internal_server_error
        end
    end 

    private
    def conference_params
        params.require(:conference).permit(
            :title, 
            :description, 
            :theme, 
            :start_date, 
            :end_date, 
            :image, 
            :status,  
            :event_url, 
            :badges_id, 
            :conference_mode_id,
            # conference_category_ids: [] yah dirct update kar raha hu iske table mei!
             )
    end

    def build_location_association(location_params)

        @conference.locations.build(
            address: location_params[:address],
            city: location_params[:city],
            pincode: location_params[:pincode],
            state_id: location_params[:state_id],
            district_id: location_params[:district_id]
        )
    end
end
