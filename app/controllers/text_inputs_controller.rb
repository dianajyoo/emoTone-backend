require("ibm_watson/tone_analyzer_v3")
require("ibm_watson/speech_to_text_v1")
require("ibm_watson/websocket/recognize_callback")
require("json")

class TextInputsController < ApplicationController

  # GET /text_inputs
  def index
    @text_inputs = TextInput.all

    render json: @text_inputs
  end

  # GET /text_inputs/:id
  def show
    render json: @text_inputs
  end

  def create

    # tone analyzer api here
    tone_analyzer = IBMWatson::ToneAnalyzerV3.new(
      iam_apikey: ENV['IBMWATSON_API_KEY'],
      version: "2017-09-21"
    )

    @result = tone_analyzer.tone(
      tone_input: strong_params["text"],
      content_type: "text/plain"
    ).result

    # speech to text api here
    speech_to_text = IBMWatson::SpeechToTextV1.new(
      iam_apikey: ENV['SPEECHTOTEXT_KEY']
    )

    File.open(Dir.getwd + "/app/audio_sample.wav") do |audio_file|
      @recognition = speech_to_text.recognize(
        audio: audio_file,
        content_type: "audio/wav",
        timestamps: true,
        word_confidence: true
      ).result
    end

    @document_tone = @result["document_tone"]["tones"]

    if @document_tone == []
      @score = 100
      @tone = 'Neutral'

      @analysis = {text: strong_params['text'], score: @score, tone: @tone}
      @textInput = TextInput.create(@analysis)
    else
      @document_tone.each do |tone|
        if tone.key?('score')
          @score = tone['score'] * 100
        end

        if tone['tone_name'] != nil || tone['tone_name'] != []
          @tone = tone['tone_name']
        end

        @analysis = {text: strong_params['text'], score: @score, tone: @tone}
        @textInput = TextInput.create(@analysis)

      end
    end

    render json: @result

  end

  private

  def strong_params
    params.require(:text_input).permit(:text, :score, :tone)
  end

end
