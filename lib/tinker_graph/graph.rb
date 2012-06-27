module TinkerGraph
  class Graph
    attr_accessor :vertices, :edges
    attr_reader :index
    
    def initialize()
      @vertices = {}
      @edges = {}
      @index = Index.new
      @next_edge_id = 0
    end
    
    def add_vertex(id)
      vertices[id] ||= Vertex.new(id, @index)
    end
    
    def get_vertex(id)
      vertices[id]
    end
    
    def remove_vertex(vertex)
      vertices.delete(vertex.id)
      vertex.clear
      vertex.property_keys.each { |key| index.remove(key, vertex.send(key.to_sym)) }
      nil
    end
    
    def add_edge(id, out_vertex, in_vertex, label)
      id ||= next_edge_id += 1 
      edge = Edge.new(id, out_vertex, in_vertex,label, @index)
      in_vertex.in_edges[edge.id] = edge
      out_vertex.out_edges[edge.id] = edge    
      edges[edge.id] = edge
      edge   
    end
  
    def remove_edge(edge)
      edges.delete(edge.id)
      in_vertex  = vertices[edge.in_vertex.id]
      out_vertex = vertices[edge.out_vertex.id]
      in_vertex  && in_vertex.in_edges.delete(edge.id)
      out_vertex && out_vertex.out_edges.delete(edge.id)   
  
      if in_vertex && in_vertex.in_edges.length == 0
        remove_vertex(in_vertex)
      end
  
      if out_vertex && out_vertex.in_edges.length == 0
        remove_vertex(out_vertex)
      end
      
      edge.clear
      nil
    end
    
    def clear
      initialize()
    end
    
    def shutdown
      nil
    end
  
    def to_s
      "graph [" + verticies.length + "]"
    end
  end
end