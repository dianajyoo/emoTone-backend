require("ibm_watson/tone_analyzer_v3")
require("json")

class TextInputsController < ApplicationController

  # GET /text_inputs
  def index
    @text_inputs = TextInput.all

    tone_analyzer = IBMWatson::ToneAnalyzerV3.new(
      iam_apikey: "",
      version: "2017-09-21"

    render json: @text_inputs
  end

  # GET /text_inputs/1
  def show
    render json: @text_inputs

  end

end
