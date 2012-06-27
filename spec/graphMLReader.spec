require 'graphMLReader'
require 'graph'
require 'index'

require 'rubygems'
require 'xml'

describe GraphMLReader do
  before(:all) do
    @graph_example_path = File.expand_path(File.dirname(__FILE__) +  
      "/fixtures/graph-example-1.xml")
  end
  
  before(:each) do
    @graph  = Graph.new    
    @reader = GraphMLReader.new(@graph, @graph_example_path)
    @simpleGraphML = @reader.graphML
  end
  
  it "should exist" do
    @reader.should be_a GraphMLReader
  end
  
  it "should create nodes from XML" do
    @simpleGraphML.find('//xmlns:node').length.should > 0
    @graph.vertices.length.should == @simpleGraphML.find('//xmlns:node').length
  end
  
  it "should add attributes to created nodes" do
    @simpleGraphML.find('//xmlns:node').each do |node|
      attributes = {}
      
      node.each_child do |data| 
        pair = @reader.convert_to_type(data.attributes["key"], data.content)
        attributes.merge!(pair[0] => pair[1]) 
      end
      
      vert = @graph.vertices[node.attributes['id']]  
      vert.properties.should == node.attributes.to_h.merge( attributes )
    end
  end
  
  it "should create edges from XML" do
    @simpleGraphML.find('//xmlns:edge').length.should > 0
    @graph.edges.length.should == @simpleGraphML.find('//xmlns:edge').length
  end
  
  it "should add attributes to created edges" do
    @simpleGraphML.find('//xmlns:edge').each do |edgeML|
      attributes = {}
      edgeML.each_child { |data| attributes.merge!({data.attributes["key"] => data.content}) }
      edge = @graph.edges[edgeML.attributes['id']]
      attributes = edgeML.attributes.to_h.merge( attributes )
      attributes.delete("source")
      attributes.delete("target")       
      typed_attributes = {}
      attributes.each_pair{ |k,v| pair = @reader.convert_to_type(k,v); typed_attributes[k] = pair[1]}
      attributes = typed_attributes        
      edge.properties.should == attributes
    end
  end
  
  it "should output the same as the parser (excepting whitespace)" do
    pending
    graph = Graph.new

    GraphMLReader.new(graph, @graph_example_path).graphML.to_s.gsub(/\s/, "").should ==           
    XML::Parser.file(@graph_example_path, :encoding => XML::Encoding::UTF_8,
               :options => XML::Parser::Options::NOBLANKS).parse.to_s.gsub(/\s/, "")
  end
end