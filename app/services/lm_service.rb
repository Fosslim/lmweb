require 'singleton'
require 'benchmark'
require_relative 'logging_hack'

class LMService
  include Singleton

  attr_reader :models, :matchers, :index_path, :index_json

  def initialize
    @@index_path = 'data/index.msgpack'
    @@index_json = 'data/licenses.json'
    @@models = {}
    @@matchers = {}

    Model.all.to_a.each do |mdl|
      mdl_id = mdl[:label].to_s
      @@models[mdl_id]    = mdl
      @@matchers[mdl_id]  =  build_model(mdl_id)
    end
  end

  def run_experiment(client, text)
    results = []

    #TODO: refactor preprocess into own class method
    clean_text = @@matchers['TFRubyMatcher'].preprocess_text(text)

    @@matcher.each_pair do |mdl_id, lm|
      results << match_license( mdl_id, clean_text )
    end

    Experiment.new(client: client, results: results, text: clean_text)
  end

  def match_license(model_id, text)
    res = Result.new(model: @@models[model_id], label: "", score: 0.0, exec_time: 0.0)


    lm = @@matchers[model_id]
    bm = Benchmark.measure do
     #TODO: refactor after gem is updated
      case model_id
      when /urlmatcher/i
        res.label = lm.match_url(text).to_s
      when /rulematcher/i
        res.label = lm.match_rule(text).to_s
      else
        m = lm.match_text text
        res.label = m.get_label()
        res.score = m.get_score()
      end
    end

    res.exec_time = bm.real
    res
  rescue
    res
  end

  def build_model(model_name)
    case model_name
    when /urlmatcher/i then LicenseMatcher::RuleMatcher.new(@@index_json)
    when /rulematcher/i then LicenseMatcher::RuleMatcher.new(@@index_json)
    when /tfrubymatcher/i then LicenseMatcher::TFRubyMatcher.new(@@index_path)
    when /tfrustmatcher/i then LicenseMatcher::TFRustMatcher.new(@@index_path)
    when /fingerprintmatcher/i then Licensematcher::FingerprintMatcher.new(@@index_path)
    end
  end

end
