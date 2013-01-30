require 'json'

module Slate
  module Calculation
    class Base
      def initialize(graph)
        @graph = graph
      end

      def result
        targets.map do |target|
          name = target.first
          points = target.last
          target name, map(points)
        end
      end

      protected

      # This is the method to do calculations in children classes
      def map(points)
        points
      end

      def targets
        data.map { |t| [t["target"], t["datapoints"].map(&:first).compact] }
      end

      def target(name, value)
        {
          "name"  => name,
          "value" => value
        }
      end

      def data
        @data ||= JSON.parse(@graph.download(:json))
      end
    end
  end
end
