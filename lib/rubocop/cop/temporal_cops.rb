# frozen_string_literal: true

module Temporal
  class TravelToWithBlock < RuboCop::Cop::Cop
    def_node_matcher(
      :travel_to,
      <<~PATTERN
        (send nil? :travel_to ...)
      PATTERN
    )

    MSG = "Always use travel_to with a block"

    def on_send(node)
      travel_to(node) do
        next if node.block_node

        add_offense(node)
      end
    end
  end
end
