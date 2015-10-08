class UsersController < ApplicationController

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: 200
    else
      render json: '400', status: 400
    end
  end

  def index
    users = User.all
    render json: users, status: 200
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    user = User.find(params[:id])

    if user.update(user_params)
      render json: user, status: 200
    else
      render json: '400', status: 400
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    head 204
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
