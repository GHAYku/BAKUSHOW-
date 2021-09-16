class Admin::TitlesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @titles = Title.all.order(created_at: :desc)
  end

  def edit
    @title = Title.find(params[:id])
  end

  def update
    @title = Title.find(params[:id])
    if @title.update(title_params)
      flash[:notice] = "編集しました"
      redirect_to admin_titles_path
    else
      render :edit
    end
  end

  def destroy
    @title = Title.find(params[:id])
    if @title.destroy
      flash[:notice] = "削除しました"
      redirect_to admin_titles_path
    end
  end

  private

  def title_params
    params.require(:title).permit(:genre_id, :body, :image)
  end
end
