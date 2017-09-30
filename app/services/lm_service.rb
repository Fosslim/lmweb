require 'singleton'
require 'benchmark'
require 'license_matcher'

require_relative 'logging_hack'

class LMService
  include Singleton

  attr_reader :models, :matchers, :index_path, :index_json

  def initialize
    @@index_path = 'data/index.msgpack'
    @@index_json = 'data/licenses.json'
    @@models = {}
    @@matchers = {}

    p "LMService loading..."
    Model.all.to_a.each do |mdl|
      mdl_id = mdl[:label].to_s
      @@models[mdl_id]    = mdl
      @@matchers[mdl_id]  =  build_matcher(mdl_id)
    end
    p "Done"
  end

  def run_experiment(client, text)
    results = []

    clean_text = LicenseMatcher::Preprocess.preprocess_text(text)

    @@matchers.each_pair do |mdl_id, lm|
      res = match_license( mdl_id, clean_text )
      results << res if res
    end

    Experiment.new(client: client, results: results, text: clean_text)
  end

  def match_license(model_id, text)
    res = Result.new(model: @@models[model_id], label: "", score: 0.0, exec_time: 0.0)

    lm = @@matchers[model_id]
    bm = Benchmark.measure do
      m = lm.match_text( text, 0.0)
      if m
        res.label = m.get_label().to_s
        res.score = m.get_score().to_f
      end

    end

    res.exec_time = bm.real.to_f
    res
  rescue => e
    p "LMService.match_license: failed to get results from `#{model_id}`"
    p "\treason: #{e.message}"
    p "Backtrace:\n\t#{e.backtrace.join("\n\t")}"
    nil
  end

  def build_matcher(model_name)
    case model_name
    when /urlmatcher/i then LicenseMatcher::UrlMatcher.new(@@index_json)
    when /rulematcher/i then LicenseMatcher::RuleMatcher.new(@@index_json)
    when /tfrubymatcher/i then LicenseMatcher::TFRubyMatcher.new(@@index_path)
    when /tfrustmatcher/i then LicenseMatcher::TFRustMatcher.new(@@index_path)
    when /fingerprintmatcher/i then LicenseMatcher::FingerprintMatcher.new(@@index_path)
    end
  end

end
