require("ibm_watson/tone_analyzer_v3")
require("json")

class TextInput < ApplicationRecord
  has_many :tones
end
