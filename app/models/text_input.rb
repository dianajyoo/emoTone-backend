require("ibm_watson/tone_analyzer_v3")
require("json")

class TextInput < ApplicationRecord
  # include HTTParty
  # base_uri 'https://gateway.watsonplatform.net/tone-analyzer/api'
  has_many :tones


end
