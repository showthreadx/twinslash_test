class AdsController < ApplicationController
  load_and_authorize_resource
  before_action :set_ad, only: [:show, :edit, :update, :destroy, :approve, :draft, :status_new]
  ActionController::Parameters.action_on_unpermitted_parameters = :raise

  def index
    if params[:search]
      @search_result_ads = Ad.where(status: 4).search_by_title_and_description(params[:search])
      respond_to do |format|
        format.js { render partial: 'search-results'}
      end
    else
      @ads = Ad.where(status: 4).paginate(page: params[:page], per_page: 10)
    end
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
    if params[:search]
      @search_result_ads = Ad.where(['user_id = ? and status != ? and status != ?', current_user.id, 4, 5]).search_by_title_and_description(params[:search])
      respond_to do |format|
        format.js { render partial: 'search-results'}
      end
    else
      @user_ads = Ad.where(['user_id = ? and status != ? and status != ?', current_user.id, 4, 5]).paginate(page: params[:page], per_page: 10) 
    end
  end

  def user_archive
    if params[:search]
      @search_result_ads = Ad.where(['user_id = ? and status = ?', current_user.id, 5]).search_by_title_and_description(params[:search])
      respond_to do |format|
        format.js { render partial: 'search-results'}
      end
    else
      @archive_ads = Ad.where(['user_id = ? and status = ?', current_user.id, 5]).paginate(page: params[:page], per_page: 10) 
    end
  end

  def delete_image
    @image = ActiveStorage::Attachment.find(params[:image_id])
    @image.purge
    flash[:success] = 'Image were successfully deleted.'
    redirect_to edit_ad_path
  end

  def show
  end

  def new
    @ad = Ad.new
  end

  def edit
  end

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

  def update
    if @ad.update(ad_params)
      flash[:success] = 'The Ad was successfully updated!'
      redirect_to request.referrer
    else
      flash[:error] = 'Sorry, an error has occurred while updating'
      redirect_to request.referrer
    end
  end

  def destroy
    @ad.destroy
    flash[:success] = 'Ad was succesfully deleted.'
    redirect_to request.referrer
  end

  private

  def set_ad
    @ad = Ad.find(params[:id])
    @ad = Ad.with_attached_images.find(params[:id]) if @ad.images.attached?
  end

  def ad_params
    params.require(:ad).permit(:title, :description, :user_id, :status, :ad_type_id, images: [])
  end
end
