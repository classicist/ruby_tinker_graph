module TinkerGraph
  class GraphVizWriter
    def write(graph)
      dot = "digraph G {\n"
      
      graph.edges.each_value do |edge|
        dot << (edge.in_vertex.id + "->" + edge.out_vertex.id + "[label = #{edge.label}]" + "\n")
      end
      
      dot += "}"
    end
    
    def write_to_file(graph, file)
      output = write(graph)
      file.puts(output)
    end
    
  end
end