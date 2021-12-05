# frozen_string_literal: true

require "spec_helper"

RSpec.describe Temporal::TravelToWithBlock do
  describe 'travel_to cop' do
    subject(:cop) { Temporal::TravelToWithBlock.new }

    context "when travel_to is called without a block" do
      it "registers an offense" do
        expect_offense(<<~RUBY)
          travel_to 2.days.ago
          ^^^^^^^^^^^^^^^^^^^^ Always use a block when time travelling
        RUBY
      end
    end

    context "when travel_to is called with a block" do
      it "does not register an offense" do
        expect_no_offenses(<<~RUBY)
          travel_to 2.days.ago do
            puts "We are not in temporal flux"
          end
        RUBY
      end
    end
  end

  describe 'freeze_time cop' do
    subject(:cop) { Temporal::TravelToWithBlock.new }

    context "when freeze_time is called without a block" do
      it "registers an offense" do
        expect_offense(<<~RUBY)
          freeze_time 2.days.ago
          ^^^^^^^^^^^^^^^^^^^^^^ Always use a block when time travelling
        RUBY
      end
    end

    context "when freeze_time is called with a block" do
      it "does not register an offense" do
        expect_no_offenses(<<~RUBY)
          freeze_time 2.days.ago do
            puts "We are not in temporal flux"
          end
        RUBY
      end
    end
  end

  describe 'travel cop' do
    subject(:cop) { Temporal::TravelToWithBlock.new }

    context "when freeze_time is called without a block" do
      it "registers an offense" do
        expect_offense(<<~RUBY)
          freeze_time 2.days.ago
          ^^^^^^^^^^^^^^^^^^^^^^ Always use a block when time travelling
        RUBY
      end
    end

    context "when freeze_time is called with a block" do
      it "does not register an offense" do
        expect_no_offenses(<<~RUBY)
          freeze_time 2.days.ago do
            puts "We are not in temporal flux"
          end
        RUBY
      end
    end
  end
end
