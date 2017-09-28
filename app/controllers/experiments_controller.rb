class ExperimentsController < ApplicationController
  layout "application"

  def new
  end

  def create
    redirect_to action: "show", id: 1, notice: "Success!"
  end

  def show
    @result_id = params[:id]

    @results = [
      {id: "TF", score: 0.9, time: 1.0},
      {id: "TF3", score: 0.8, time: 2.0}
    ]


  end


end
