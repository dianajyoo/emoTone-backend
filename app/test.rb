require("ibm_watson/tone_analyzer_v3")
require("json")

tone_analyzer = IBMWatson::ToneAnalyzerV3.new(
  iam_apikey: "FXLZ8taHLH8n3MBUyk_x67lcG1eWd14g939yv1jCDcan",
  version: "2017-09-21"
)

result = tone_analyzer.tone(
  tone_input: "I am very happy. It is a good day.",
  content_type: "text/plain"
).result

 puts result