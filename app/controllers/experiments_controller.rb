class ExperimentsController < ApplicationController
  layout "application"
  before_action :valid_token?, only: [:create]

  def new
    @example = A_MIT_TEXT
  end

  def create
    client = Client.where(token: params[:token].to_s).first

    exp = LMService.instance.run_experiment(client, params[:lic_text].to_s)
    unless exp.save
      redirect_to new_experiment_path, notice: "Failed to save experiment: #{exp.errors.full_messages.to_sentence}"

    else
      redirect_to action: "show", id: exp.id, notice: "Success!"
    end

  end

  def show
    @result_id = params[:id]
    @experiment = Experiment.find(@result_id)
  end


  private

  def valid_token?
    res = false if params[:token].to_s.empty?
    res = true if params[:token] == 'demo1234' #TODO: remove after demo
    res ||= Client.exists?(token: params[:token])

    return if res == true

    error_msg = "Wrong Client token - demo token is close to upload form;"
    redirect_to new_experiment_path, notice: error_msg
  end

  A_MIT_TEXT = <<-EOF
    Copyright <YEAR> <COPYRIGHT HOLDER>

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is furnished
    to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.


    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
    OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
    AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
    THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

  EOF
end
