module TinkerGraph
  require 'rubygems'
  require 'xml'
  
  class GraphMLReader
    attr_reader :graphML
    
    def initialize(graph, graph_xml_file)
      @graph = graph
      @graphML = XML::Parser.file(graph_xml_file, :encoding => XML::Encoding::UTF_8,
                 :options => XML::Parser::Options::NOBLANKS).parse
      @default_namespace = 'xmlns'
      @graphML.root.namespaces.default_prefix = @default_namespace
      create_vertices
      create_edges
    end
  
    def convert_to_type(key, value)
      key_type = @graphML.root.find( %!/#{dns}key[@attr.name="#{key}"]! ).first
      key_type = key_type.attributes['attr.type'] if key_type
  
      cast = case key_type
        when "float"
          :to_f
        when "string"
          :to_s
        when "int"
          :to_i
      end 
      value = value.send(cast) if cast
      [key, value]
    end
  
  private
    def create_vertices
      @graphML.find("//#{dns}node").each do |nodeML|  
        vertex = @graph.add_vertex(nodeML.attributes['id'])
              
        nodeML.children.each do |data|
          vertex.set_property( *convert_to_type(data.attributes['key'], data.content))
        end
      end
    end
    
    def create_edges
      @graphML.find("//#{dns}edge").each do |edgeML| 
        
        edge_id = edgeML.attributes['id']
        in_vertex =  @graph.vertices[edgeML.attributes['target']]
        out_vertex = @graph.vertices[edgeML.attributes['source']]
        label = edgeML.attributes['label']
        
        edge = @graph.add_edge(edge_id, in_vertex, out_vertex, label)
              
        edgeML.children.each do |data|
          edge.set_property( *convert_to_type(data.attributes['key'], data.content) )
        end
      end
    end
    
    def dns
     @default_namespace + ":"
    end
  end
end