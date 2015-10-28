class LinesController < ApplicationController
  def index
    haiku = Haiku.find(params[:haiku_id])
    lines = haiku.lines
    render json: lines, each_serializer: LineSerializer
  end

  def create
    haiku = Haiku.find(params[:haiku_id])
    line = haiku.lines.build(line_params)
    if line.save
      render json: line, status: 201
    else
      render json: '400', status: 400
    end
  end

  def update
    line = Line.find(params[:id])
    if line.update_attributes(line_params)
      render json: line
    else
      render json: '400', status: 400
    end
  end

  def show
    line = Line.find(params[:id])
    render json: line
  end

  def destroy
    line = Line.find(params[:id])
    line.destroy
    head 204
  end

  private

    def line_params
      params.permit(:haiku_id, :content)
    end
end
