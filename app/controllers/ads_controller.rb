class AdsController < ApplicationController
  helper_method :sort_column, :sort_direction
  load_and_authorize_resource
  before_action :set_ad, only: [:show, :edit, :update, :destroy, :approve, :draft, :status_new]
  ActionController::Parameters.action_on_unpermitted_parameters = :raise

  def index
    @filter = Ad.ransack(params[:q])
    if params[:query]
      @ads = Ad.where(status: 4).search(params[:query]).includes(:user, :ad_type).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
    else
      @ads = @filter.result.where(status: 4).includes(:user, :ad_type).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
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
    @filter = Ad.ransack(params[:q])
    if params[:query]
      @ads = Ad.where(user_id: current_user.id, status: [0, 1, 2, 3]).search(params[:query]).includes(:ad_type).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
    else
      @ads = @filter.result.where(user_id: current_user.id, status: [0, 1, 2, 3]).includes(:ad_type).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10) 
    end
  end

  def user_archive
    @filter = Ad.ransack(params[:q])
    if params[:query]
      @ads = Ad.where(user_id: current_user.id, status: 5).search(params[:query]).includes(:user, :ad_type).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
    else
      @ads = @filter.result.where(user_id: current_user.id, status: 5).includes(:user, :ad_type).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10) 
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
    @ad = current_user.ads.new(ad_params)
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

  def sort_column
    Ad.column_names.include?(params[:sort]) ? params[:sort] : 'title'
  end

  def sort_direction
    params[:direction] || 'asc'
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
