# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/temporal'
require_relative 'rubocop/temporal/version'
require_relative 'rubocop/temporal/inject'

RuboCop::Temporal::Inject.defaults!

require_relative 'rubocop/cop/temporal_cops'
