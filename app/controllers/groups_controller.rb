class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(name: group_params[:name])
    group_params[:user_ids].each do |user_id|
      next if user_id.empty?
      @group.members.new(user_id: user_id)
    end
    if @group.save
      flash[:notice] = 'グループを作成しました'
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private
  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end
end

