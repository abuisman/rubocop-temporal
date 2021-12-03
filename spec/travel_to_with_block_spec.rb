# frozen_string_literal: true

require "spec_helper"

RSpec.describe Temporal::TravelToWithBlock do
  subject(:cop) { Temporal::TravelToWithBlock.new }

  context "when travel_to is called without a block" do
    it "registers an offense" do
      expect_offense(<<~RUBY)
        travel_to 2.days.ago
        ^^^^^^^^^^^^^^^^^^^^ Always use travel_to with a block
      RUBY
    end
  end

  context "when travel_to is called with a block" do
    it "does not register an offense" do
      expect_no_offenses(<<~RUBY)
        travel_to 2.days.ago do
          puts "Haha"
        end
      RUBY
    end
  end
end
