module TinkerGraph  
  require 'element'
  class Vertex < Element
    attr_accessor :out_edges, :in_edges
    
    def initialize(id, index)
      super(id, index)
      @out_edges = {}
      @in_edges  = {}
    end  
    
    def clear
      super.clear
      @out_edges = {}
      @in_edges  = {}
    end
  end
end