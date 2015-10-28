class HaikusController < ApplicationController

  def index
    haikus = Haiku.all
    render json: haikus
  end

  def show
    haiku = Haiku.find(params[:id])
    render json: haiku
  end

  def create
    haiku = Haiku.new(haiku_params)
    if haiku.save
      render json: haiku.lines, status: 201
    else
      render json: '400', status: 400
    end
  end

  def update
    haiku = Haiku.find(params[:id])
    if haiku.lines.first.update_attributes(line_params)
      render json: haiku.lines
    else
      render json: '400', status: 400
    end
  end

  def destroy
    haiku = Haiku.find(params[:id])
    haiku.destroy
    head 204
  end

  def random
    haiku = RandomHaiku.new
    if haiku.save
      render json: haiku.lines, status: 201
    else
      render json: '400', status: 400
    end
  end

  private

  def haiku_params
    params.permit(lines_attributes: [:haiku_id, :content])
  end

  def line_params
    params.permit(:haiku_id, :content)
  end

end
