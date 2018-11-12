require("ibm_watson/tone_analyzer_v3")
require("json")

class TextInputsController < ApplicationController

  # GET /text_inputs
  def index
    @text_inputs = TextInput.all

    tone_analyzer = IBMWatson::ToneAnalyzerV3.new(
      iam_apikey: ENV['IBMWATSON_API_KEY'],
      version: "2017-09-21"
    )

    result = tone_analyzer.tone(
      tone_input: "I am very happy. It is a good day.",
      content_type: "text/plain"
    ).result

    render json: result
  end

  # GET /text_inputs/1
  def show
    render json: @text_inputs

  end

end
