# encoding: utf-8
require 'spec_helper'
require 'gherkin/i18n_lexer'
require 'gherkin/listener/formatter_listener'
require 'gherkin/formatter/tag_count_formatter'

module Gherkin
  module Formatter
    describe TagCountFormatter do
      it "should count tags" do
        dummy = Gherkin::SexpRecorder.new
        formatter = Gherkin::Formatter::TagCountFormatter.new(dummy)
        parser = Gherkin::Parser::Parser.new(formatter)

        f = File.new(File.dirname(__FILE__) + "/../fixtures/complex_with_tags.feature").read
        parser.parse(f, 'f.feature', 0)
        
        formatter.tag_counts.should == {
          "@hamster" => ["f.feature:58"],
          "@tag1"    => ["f.feature:18","f.feature:23","f.feature:39","f.feature:52","f.feature:58"],
          "@tag2"    => ["f.feature:18","f.feature:23","f.feature:39","f.feature:52","f.feature:58"],
          "@tag3"    => ["f.feature:18", "f.feature:23"],
          "@tag4"    => ["f.feature:18"],
          "@neat"    => ["f.feature:52"],
          "@more"    => ["f.feature:52", "f.feature:58"]
        }
      end
    end
  end
end