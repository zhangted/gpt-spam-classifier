# frozen_string_literal: true

require "openai"
require "json"

RSpec.describe Gpt::Spam::Classifier do
  let(:api_key) { "my-api-key" }
  let(:model) { "my-model"}

  it "has a version number" do
    expect(Gpt::Spam::Classifier::VERSION).not_to be nil
  end

  it "request returns error without api key" do
    expect(Gpt::Spam::Classifier.classify_single_agent('',  nil)).to eq(Gpt::Spam::Classifier.error_hash(NoApiKey.new))
  end

  it "returns an error message when the response is empty hash" do
    client_mock = double("OpenAI::Client")
    allow(OpenAI::Client).to receive(:new).and_return(client_mock)
    allow(client_mock).to receive(:chat).and_return({})

    result = Gpt::Spam::Classifier.classify_single_agent("some text", api_key, model)
    expect(result).to eq(Gpt::Spam::Classifier.error_hash(TypeError.new))
  end

  it "returns the proper data when response is valid" do
    client_mock = double("OpenAI::Client")
    allow(OpenAI::Client).to receive(:new).and_return(client_mock)

    valid_response_obj = {
      "choices" => [{
        "message" => {
          "content" => "{\"spam_level\": 5, \"reason\": \"some reason\"}"
        }
      }]
    }
    allow(client_mock).to receive(:chat).and_return(valid_response_obj)

    result = Gpt::Spam::Classifier.classify_single_agent("some text", api_key, model)
    expect(result).to eq(JSON.parse(valid_response_obj.dig('choices', 0, 'message', 'content')))
  end


  it "returns error message when response structure is valid but data has parsing issue" do
    client_mock = double("OpenAI::Client")
    allow(OpenAI::Client).to receive(:new).and_return(client_mock)

    valid_response_obj = {
      "choices" => [{
        "message" => {
          "content" => "{spam_level\": 5, \"reason\": \"some reason\"}"
        }
      }]
    }
    allow(client_mock).to receive(:chat).and_return(valid_response_obj)

    result = Gpt::Spam::Classifier.classify_single_agent("some text", api_key, model)
    expect(result).to eq(Gpt::Spam::Classifier.error_hash(JSON::ParserError.new))
  end


  it "returns error message when response is not structured as expected" do
      client_mock = double("OpenAI::Client")
      allow(OpenAI::Client).to receive(:new).and_return(client_mock)

      valid_response_obj = {
        "choices" => [{
          "message" => {
            "content" => "hackermans"
          }
        }]
      }
      allow(client_mock).to receive(:chat).and_return(valid_response_obj)

      result = Gpt::Spam::Classifier.classify_single_agent("some text", api_key, model)
      expect(result).to eq(Gpt::Spam::Classifier.error_hash(JSON::ParserError.new))
    end


  it "returns error message when response contains error message" do
    client_mock = double("OpenAI::Client")
    allow(OpenAI::Client).to receive(:new).and_return(client_mock)

    err_response_obj = {
      "error" => {
        "message" => "hello"
      }
    }
    allow(client_mock).to receive(:chat).and_return(err_response_obj)

    result = Gpt::Spam::Classifier.classify_single_agent("some text", api_key, model)
    expect(result).to eq(Gpt::Spam::Classifier.error_hash(ResponseServerErrorMessage.new(err_response_obj['error']['message'])))
  end
end
