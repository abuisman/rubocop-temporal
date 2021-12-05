# frozen_string_literal: true

module Temporal
  class TravelToWithBlock < RuboCop::Cop::Cop
    def_node_matcher(
      :travel_to,
      <<~PATTERN
        (send nil? {:travel_to | :freeze_time | :travel} ...)
      PATTERN
    )

    MSG = "Always use a block when time travelling"

    def on_send(node)
      travel_to(node) do
        next if node.block_node

        add_offense(node)
      end
    end
  end
end
