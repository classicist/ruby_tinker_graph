require 'graphVizWriter'
require 'graphMLReader'
require 'graph'
require 'index'
require 'rubygems'
require 'xml'

describe GraphVizWriter do
  before(:all) do
    @graph_example_path = File.expand_path(File.dirname(__FILE__) +  
      "/fixtures/graph-example-1.xml")  
    fixture = File.open(File.expand_path(File.dirname(__FILE__) +  
        "/fixtures/graph-example-1.dot"), "r")
    fixture.pos = 0
    @digraph_fixture = fixture.read.chomp
    fixture.close
  end
  
  before(:each) do
    @graph  = Graph.new       
    GraphMLReader.new(@graph, @graph_example_path)    
    @writer = GraphVizWriter.new
  end
  
  it "should exist" do
    @writer.should be_a GraphVizWriter
  end
  
  it "should write itself out in basic dot" do
    @graph.edges.length.should > 0    
    @writer.write(@graph).should == @digraph_fixture
  end
  
  it "should write itself out to a file" do
    @graph.edges.length.should > 0 
    StringIO.open("/Users/paul/Desktop/graph.gv") do |file|
      @writer.write_to_file(@graph, file)
      file.pos = 0;
      file.read.chomp.should == @digraph_fixture
    end
  end
end