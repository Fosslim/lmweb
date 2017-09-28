# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

models = Model.create([
  {label: "UrlMatcher", language: "Ruby", summary: "Matches SPDX urls", description: "Simple regex based model which checks does the url matches with official urls to the SPDX or to the Opensource.org listing"},
  {label: "RuleMatcher", language: "Ruby", summary: "Matches parts of text with various handcrafted Regexp rules", description: "It returns the rule which matches biggest part of the text." },
  {label: "TFRubyMatcher", language: "Ruby", summary: "Compares document similarities ith TF & Cosine similarity", description: "The original implementaiton of Licensematcher. It compares termvectors between indexed documents and user document."},

  {label: "TFRustMatcher", language: "Rust", summary: "Compares document similarities by word existance", description: "The first Rust implementation. It splits document into term vector, ignores TF & IDF part and measure similarity based on Jaccard distance"},
  {label: "FingerprintMatcher", language: "Rust", summary: "Matches documents based on similar hashes", description: "The first implementation of Hash based matching; It splits text into overlapping NGrams, calculates hash values and picks some of them to represent document; It measures similarity based on number of matching hash values"}
])

p "Added: #{models.size} new models"


u = Client.create(name: "Demo User", active: true, token: "demo1234")
p "Add demo user: #{u.name}"
