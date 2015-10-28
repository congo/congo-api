class Api::V1::EnrollmentsController < ::ApplicationController
  before_action :set_enrollment, only: [:show, :update, :destroy]

  # GET /enrollments
  # GET /enrollments.json
  def index
    @enrollments = Enrollment.all

    # Search
    @enrollments = @enrollments.search(params[:q]) if params[:q]

    # Filter for group
    #@enrollments = @enrollments.relationship(params[:group]) if params[:group]

    # Order by
    @enrollments = @enrollments.order(params[:order].gsub(':', ' ')) if params[:order]

    # Pagination
    if (params[:offset] && params[:limit])
      @enrollments = @enrollments.page(1).per(params[:limit]).padding(params[:offset])
    else
      @enrollments = @enrollments.page(1).per(25)
    end

    render json: @enrollments if stale?(etag: @enrollments.all, last_modified: @enrollments.maximum(:updated_at))
  end

  # GET /enrollments/1
  # GET /enrollments/1.json
  def show
    if(@enrollment.present?)
      render json: @enrollment.properties_data if stale?(@enrollment)
    else
      render json: {}, status: :not_found
    end
  end

  # POST /enrollments
  # POST /enrollments.json
  def create

    @enrollment = Enrollment.new(properties_data: enrollment_properties_params)
    #debugger
    #@enrollment = Enrollment.new()
    #render json: request.raw_post(), status: :created

    if @enrollment.save
      render json: @enrollment, status: :created
    else
      render json: @enrollment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /enrollments/1
  # PATCH/PUT /enrollments/1.json
  def update
    #debugger
    if @enrollment.update(enrollment_params)
      head :no_content
    else
      render json: @enrollment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /enrollments/1
  # DELETE /enrollments/1.json
  def destroy
    @enrollment.destroy

    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enrollment_params
      #json_data = request.raw_post()
      #params.require(:reference_number).permit(:name, :email, :twitter)
      params.permit(:dependents)
    end

    def enrollment_properties_params()
      JSON.parse(request.raw_post)
    end
end
