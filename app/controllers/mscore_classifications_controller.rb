class MscoreClassificationsController < ApplicationController
  before_action :set_mscore_classification, only: [:edit, :update, :destroy]
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :js_request?
  # GET /mscore_classifications/new
  def new
    @mscore_classification = MscoreClassification.new
  end

  # GET /mscore_classifications/1/edit
  def edit
  end

  # POST /mscore_classifications
  # POST /mscore_classifications.json
  def create
    @mscore_classification = MscoreClassification.new(mscore_classification_params)

      if @mscore_classification.save
        flash[:success] =  'Mscore classification was successfully created.'
        redirect_to :back
      else
        flash[:danger] =  'Mscore classification was not created.'
        redirect_to :back
      end
  end

  # PATCH/PUT /mscore_classifications/1
  # PATCH/PUT /mscore_classifications/1.json
  def update

      if @mscore_classification.update(mscore_classification_params)
        flash[:success] =  'Mscore classification was successfully updated.'
        redirect_to :back

      else
        flash[:danger] =  'Mscore classification was not updated.'
        redirect_to :back
      end

  end

  # DELETE /mscore_classifications/1
  # DELETE /mscore_classifications/1.json
  def destroy
    @mscore_classification.destroy
    flash[:success] =  'Mscore classification was successfully deleted.'
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def js_request?
        request.format.js?
    end
    def set_mscore_classification
      @mscore_classification = MscoreClassification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mscore_classification_params
      params.require(:mscore_classification).permit(:name)
    end
end
