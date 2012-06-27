module TinkerGraph
  require 'GraphMLTokens'
  require 'rubygems'
  require 'xml'
  
  class GraphMLWriter
    attr_reader :graphML
    
    def initialize(graph)
      @graph = graph
      @graphML = XML::Document.new
      writeGraphML
    end
  
  private  
    def writeGraphML
        create_root
        create_key_nodes
        create_graph
    end
  
  def create_root
    root = create_node(TinkerGraph::GraphMLTokens::GRAPHML,
                   :namespaces => { "default" => TinkerGraph::GraphMLTokens::GRAPHML_XMLNS,
                                    "xsi" => "http://www.w3.org/2001/XMLSchema-instance",
                                    "xmlns" => TinkerGraph::GraphMLTokens::GRAPHML_XMLNS
                                  },
                   :attributes => { "xsi:schemaLocation" => "http://graphml.graphdrawing.org/xmlns         http://graphml.graphdrawing.org/xmlns/1.0/graphml.xsd"
                                  }
                  )
    
    default = root.namespaces.find_by_href( TinkerGraph::GraphMLTokens::GRAPHML_XMLNS )
    root.namespaces.namespace = default
    @graphML.root = root
  end
  
  def create_key_nodes
      TinkerGraph::GraphMLTokens::EDGE_TYPES.each do |key_node|
        vertex = XML::Node.new( "key")
        
        key_node.each_pair do |id, type|
          [{"id" => id}, {"for" => "edge"}, {"attr.name" => id}, {"attr.type" => type}].each do |attribute|
            XML::Attr.new( vertex, attribute.keys[0], attribute.values[0] )
          end
        end
        
        vertex.namespaces.namespace = @graphML.root.namespaces.default
        @graphML.root << vertex      
      end
      
      TinkerGraph::GraphMLTokens::VERTEX_TYPES.each do |key_node|
        vertex = XML::Node.new( "key")
        
        key_node.each_pair do |id, type|
          [{"id" => id}, {"for" => "node"}, {"attr.name" => id}, {"attr.type" => type}].each do |attribute|
            XML::Attr.new( vertex, attribute.keys[0], attribute.values[0] )
          end
        end  
          
        vertex.namespaces.namespace = @graphML.root.namespaces.default
        @graphML.root << vertex
      end
  end
  
  def create_graph
    graph_node = XML::Node.new("graph")
    XML::Attr.new(graph_node, "id", "G")
    XML::Attr.new(graph_node, "edgedefault", "directed")  
    graph_node.namespaces.namespace = @graphML.root.namespaces.default
    create_graph_nodes(graph_node)
    @graphML.root << graph_node
  end
  
  def create_graph_nodes(graph_node)  
   
    @graph.vertices.values.sort.each do |vertex|
        vertex_node = XML::Node.new("node")
        XML::Attr.new(vertex_node, "id", vertex.id)
        vertex_node.namespaces.namespace = @graphML.root.namespaces.default
  
        vertex.properties.each_pair do |key, value|
          next if key == "id"
          data_node = XML::Node.new("data")
          data_node.content = value
          XML::Attr.new(data_node, "key", key)
          data_node.namespaces.namespace = @graphML.root.namespaces.default
          vertex_node << data_node
        end
      graph_node << vertex_node
    end
    
    @graph.edges.values.sort.each do |edge|
        edge_node = XML::Node.new("edge")
        XML::Attr.new(edge_node, "id", edge.id)
        XML::Attr.new(edge_node, "source", edge.in_vertex.id)
        XML::Attr.new(edge_node, "target", edge.out_vertex.id)
        XML::Attr.new(edge_node, "label", edge.label)
        
        edge_node.namespaces.namespace = @graphML.root.namespaces.default
  
        edge.properties.each_pair do |key, value|
          next if (key == "id" || key == "label")
          data_node = XML::Node.new("data")
          data_node.content = value
          XML::Attr.new(data_node, "key", key)
          data_node.namespaces.namespace = @graphML.root.namespaces.default
          edge_node << data_node
        end
      graph_node << edge_node
    end
  end
  
  #<edge id="8" source="1" target="4" label="knows">
  #  <data key="weight">1.0</data>
  #</edge>,
  
  
  #add a list of namespaces to the node
  #the namespaces formal parameter is a hash
  #with "prefix" and "prefix_uri" as
  #key, value pairs
  #prefix for the default namespace is "default"
  def add_namespaces( node, namespaces )
    #pass nil as the prefix to create a default node
    default = namespaces.delete( "default" )
    node.namespaces.namespace = XML::Namespace.new( node, nil, default )
    namespaces.each do |prefix, prefix_uri|
      XML::Namespace.new( node, prefix, prefix_uri )
    end
  end
  
  #add a list of attributes to the node
  #the attributes formal parameter is a hash
  #with "name" and "value" as
  #key, value pairs
  def add_propertys( node, attributes )
    attributes.each do |name, value|
      XML::Attr.new( node, name, value )
    end
  end
  
  #create a node with name
  #and a hash of namespaces or attributes
  #passed to options
  def create_node( name, options )
    node = XML::Node.new( name )
  
    namespaces = options.delete( :namespaces )
    add_namespaces( node, namespaces ) if namespaces
  
    attributes = options.delete( :attributes )
    add_propertys( node, attributes ) if attributes
    node
  end
   
  end
end