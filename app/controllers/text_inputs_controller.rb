require("ibm_watson/tone_analyzer_v3")
require("json")

class TextInputsController < ApplicationController

  # GET /text_inputs
  def index
    @text_inputs = TextInput.all

    # tone_analyzer = IBMWatson::ToneAnalyzerV3.new(
    #   iam_apikey: ENV['IBMWATSON_API_KEY'],
    #   version: "2017-09-21"
    # )
    #
    # @result = tone_analyzer.tone(
    #   tone_input: strong_params["text"],
    #   content_type: "text/plain"
    # ).result
    # # byebug
    #
    render json: @text_inputs.to_json
  end

  # GET /text_inputs/:id
  def show
    render json: @text_inputs.to_json
  end

  def create
    @text_input = TextInput.create(@analysis)

    tone_analyzer = IBMWatson::ToneAnalyzerV3.new(
      iam_apikey: ENV['IBMWATSON_API_KEY'],
      version: "2017-09-21"
    )

    @result = tone_analyzer.tone(
      tone_input: strong_params["text"],
      content_type: "text/plain"
    ).result

    @score = @result['document_tone']['tones'][0]['score']
    @tone = @result['document_tone']['tones'][0]['tone_name']

    @analysis = {text: strong_params['text'], score: @score, tone: @tone}
    # byebug

    render json: @analysis.to_json

  end

  private

  def strong_params
    params.require(:text_input).permit(:text, :score, :tone)
  end

end
