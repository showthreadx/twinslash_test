class AdsController < ApplicationController
  load_and_authorize_resource
  before_action :set_ad, only: [:show, :edit, :update, :destroy, :approve, :draft, :status_new]
  ActionController::Parameters.action_on_unpermitted_parameters = :raise

  # GET /ads
  # GET /ads.json
  def index
    @ads = Ad.where(status: 4).paginate(page: params[:page], per_page: 5) 
  end

  def status_new
    @ad.update_attributes status: 1
    flash[:success] = 'Success! Ad will be published after admin approval.'
    redirect_to user_ads_ads_path
  end

  def status_draft
    @ad.update_attributes status: 0
    flash[:success] = 'The Ad was successfully converted to Draft Type.'
    redirect_to user_archive_ads_path
  end

  def user_ads
    @user_ads = Ad.where(['user_id = ? and status != ?', current_user.id, 4]).paginate(page: params[:page], per_page: 5) 
  end

  def user_archive
    @archive_ads = Ad.where(['user_id = ? and status = ?', current_user.id, 5]).paginate(page: params[:page], per_page: 5) 
  end

  def delete_image
    @image = ActiveStorage::Attachment.find(params[:image_id])
    @image.purge
    flash[:success] = 'Image were successfully deleted.'
    redirect_to edit_ad_path
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
  end

  # GET /ads/new
  def new
    @ad = Ad.new
  end

  # GET /ads/1/edit
  def edit
    @ad = Ad.find(params[:id])
  end

  # POST /ads
  # POST /ads.json
  def create
    @ad = Ad.new(ad_params)
    @ad.user_id = current_user.id
    if @ad.save!
      flash[:success] = 'Ad was succesfully created! You can see it in Your ads list.'
      redirect_to user_ads_ads_path
    else
      flash[:warning] = "Something go wrong. Please, try again"
      render 'new'
    end
  end

  # PATCH/PUT /ads/1
  # PATCH/PUT /ads/1.json
  def update
    if @ad.update(update_params)
      flash[:success] = 'The Ad was successfully updated!'
      redirect_to request.referrer
    else
      flash[:error] = 'Sorry, an error has occurred while updating'
      redirect_to request.referrer
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    @ad.destroy
    flash[:success] = 'Ad was succesfully deleted.'
    redirect_to request.referrer
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ad
    @ad = Ad.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ad_params
    params.require(:ad).permit(:title, :description, :user_id, :status, :ad_type_id, images: [])
  end

  def update_params
    if current_user.admin?
      params.require(:ad).permit(current_ability.permitted_attributes(:update, @ad))
    else
      params.require(:ad).permit(:title, :description, :user_id, :status, :ad_type_id, images: [])
    end
  end
end
