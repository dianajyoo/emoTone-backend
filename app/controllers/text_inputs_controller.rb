class TextInputsController < ApplicationController

  def index
    @text_inputs = TextInput.all

    render json: @text_inputs
  end

  def show
    render json: 

  end

end
