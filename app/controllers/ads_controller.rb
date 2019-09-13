class AdsController < ApplicationController
  before_action :set_ad, only: [:show, :edit, :update, :destroy, :approve, :pending]

  # GET /ads
  # GET /ads.json
  def index
    if current_user
      @my_ads = Ad.where(['user_id = ? and status != ?', current_user.id, 3])
    end
    @ads = Ad.where(status: 3)
  end

  def approve
    authorize! :approve, @ad
    @ad = Ad.find(params[:id])
    @ad.update_attributes status: 3
  end

  def pending
    authorize! :pending, Ad
    @ad = Ad.find(params[:id])
    @ad.update_attributes status: 1
    redirect_to :root
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
  end

  # GET /ads/new
  def new
    authorize! :new, Ad
    @ad = Ad.new
  end

  # GET /ads/1/edit
  def edit
    authorize! :edit, @ad
  end

  # POST /ads
  # POST /ads.json
  def create
    authorize! :create, Ad
    @ad = Ad.new(ad_params)
    @ad.user_id = current_user.id

    respond_to do |format|
      if @ad.save
        format.html { redirect_to @ad, notice: 'Ad has been saved. You can edit or publish it in the list of your saved ads' }
        format.json { render :show, status: :created, location: @ad }
      else
        format.html { render :new }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ads/1
  # PATCH/PUT /ads/1.json
  def update
    respond_to do |format|
      if @ad.update(ad_params)
        format.html { redirect_to @ad, notice: 'Ad was successfully updated.' }
        format.json { render :show, status: :ok, location: @ad }
      else
        format.html { render :edit }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    authorize! :destroy, @ad
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to ads_url, notice: 'Ad was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad
      @ad = Ad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_params
      params.require(:ad).permit(:title, :description, :user_id, :status, images: [])
    end
end
