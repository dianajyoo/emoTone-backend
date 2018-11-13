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
    render json: @text_inputs
  end

  # GET /text_inputs/:id
  def show
    render json: @text_inputs
  end

  def create
    tone_analyzer = IBMWatson::ToneAnalyzerV3.new(
      iam_apikey: ENV['IBMWATSON_API_KEY'],
      version: "2017-09-21"
    )

    @result = tone_analyzer.tone(
      tone_input: strong_params["text"],
      content_type: "text/plain"
    ).result

    # byebug
    if @result["document_tone"]["tones"].length > 1

      @score1 = @result["document_tone"]['tones'][1]['score'] * 100
      @tone1 = @result["document_tone"]['tones'][1]['tone_name']
      @analysis1 = {text: strong_params['text'], score: @score1, tone: @tone1}

      if (@tone1 == nil) || (@tone1 == [])
        @tone1 = "Tentative"
      end

      @text_input2 = TextInput.create(@analysis1)

    end

    @score = @result['document_tone']['tones'][0]['score'] * 100
    @tone = @result['document_tone']['tones'][0]['tone_name']

    @analysis = {text: strong_params['text'], score: @score, tone: @tone}
    @text_input = TextInput.create(@analysis)

    render json: @result

  end

  private

  def strong_params
    params.require(:text_input).permit(:text, :score, :tone)
  end

end
