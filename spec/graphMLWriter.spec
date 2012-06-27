require 'graphMLWriter'
require 'graphMLReader'
require 'graph'
require 'index'
require 'rubygems'
require 'xml'

describe GraphMLWriter do
  before(:all) do
    @graph_example_path = File.expand_path(File.dirname(__FILE__) +  
      "/fixtures/graph-example-1.xml")
  end
  
  before(:each) do
    @graph  = Graph.new    
    @reader = GraphMLReader.new(@graph, @graph_example_path)
    @writer = GraphMLWriter.new(@graph)
    @fixtureGraphML = @reader.graphML
  end
  
  it "should exist" do
    @writer.should be_a GraphMLWriter
  end
  
  it "should generate graphML root node with correct attriubutes" do
    pending "libxml 2.6.16 does not correctly build namespaced attributes, waiting for upgrade"
    result_set = Set.new
    expected_set = Set.new
    @writer.graphML.root.attributes.to_h.each_pair{ |k,v| result_set   <<k; result_set<<v}
    @reader.graphML.root.attributes.to_h.each_pair{ |k,v| expected_set <<k; expected_set<<v}
    result_set.should == expected_set
  end

  it "should generate graphML root node with correct namespaces" do
    @writer.graphML.root.namespaces.to_a.should == @reader.graphML.root.namespaces.to_a
  end
  
  it "should generate graphML key type nodes" do
     xpath = "//xmlns:key" 
     @reader.graphML.root.find( xpath ).to_a.length.should > 0
     @writer.graphML.root.find( xpath ).to_a.should == @reader.graphML.root.find( xpath ).to_a
  end
  
  it "should generate a graph node to hold nodes" do
     xpath = "//xmlns:graph" 
     @reader.graphML.root.find( xpath ).to_a.length.should > 0
     @writer.graphML.root.find( xpath ).first.attributes.to_h.should == @reader.graphML.root.find( xpath ).first.attributes.to_h    
  end
  
  it "should generate vertex nodes in the graph" do
     xpath = "//xmlns:graph/xmlns:node" 
     @reader.graphML.root.find( xpath ).to_a.length.should > 0
     @writer.graphML.root.find( xpath ).to_a.should == @reader.graphML.root.find( xpath ).to_a
  end

  it "should generate edge nodes in the graph" do
     xpath = "//xmlns:graph/xmlns:edge" 
     @reader.graphML.root.find( xpath ).to_a.length.should > 0
     @writer.graphML.root.find( xpath ).to_a.should == @reader.graphML.root.find( xpath ).to_a
  end  
  
  it "writer should to_s be the same as the reader" do
    @writer.graphML.to_s.should == @reader.graphML.to_s
  end
  
  
  it "parser should to_s be the same as the file (excepting whitespace)" do
    XML::Parser.file(@graph_example_path, :encoding => XML::Encoding::UTF_8,
               :options => XML::Parser::Options::NOBLANKS).parse.to_s.gsub(/\s/, "").should ==
               File.open(@graph_example_path, "r").read.gsub(/\s/, "")
  end
end