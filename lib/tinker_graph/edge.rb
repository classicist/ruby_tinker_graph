module TinkerGraph
  require 'element'

  class Edge < Element
      attr_reader :out_vertex, :in_vertex
      attr_reader :label
      
      def initialize(id, out_vertex, in_vertex, label, index)
        super(id, index)
        @label = label
        @properties["label"] = label
        @out_vertex = out_vertex
        @in_vertex = in_vertex
      end
      
      def clear
        super.clear
        @properties["label"] = @label
      end    
  end
end