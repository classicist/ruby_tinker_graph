require 'graph'
require 'edge'
require 'vertex'
require 'index'


describe Graph do
  
  before(:each) do
    @graph = Graph.new
    @in_vertex = @graph.add_vertex(2);
    @out_vertex = @graph.add_vertex(3);    
    @edge = @graph.add_edge(1, @out_vertex, @in_vertex, "mike")
  end
  
  it "should add a vertex" do
    @graph.vertices.keys.should == [2, 3]
  end
  
  it "should get a vertex" do
    @graph.get_vertex(2).should == @in_vertex
  end

  it "should remove a vertex" do
    original_length =  @graph.vertices.length
    @graph.remove_vertex(@in_vertex)
    @graph.vertices.length.should == original_length - 1
  end
  
  it "should remove an edge when one of its verticies are removed" do
    @graph.remove_vertex(@in_vertex)
    @graph.edges.length.should == 0;
    @graph.verticies.length.should == 1;
  end
  
  it "should add an edge and get the edge collection" do
    @graph.edges.should == {@edge.id => @edge}
  end

  it "should add vertices to graph when adding an edge" do
    @graph.vertices.should == {@in_vertex.id => @in_vertex, @out_vertex.id => @out_vertex}
  end

  it "should add vertices to edge when adding an edge" do
    @edge.in_vertex.should == @in_vertex
    @edge.out_vertex.should == @out_vertex
  end
  
  it "should add the edge to the vertices when adding an edge" do
    @in_vertex.in_edges.should   == {@edge.id => @edge}
    @out_vertex.out_edges.should == {@edge.id => @edge}
  end
  
  it "should remove an edge from the graph" do    
    @graph.remove_edge(@edge)
    @graph.edges.should == {}
  end
  
  it "should remove the edge from its vertices" do
    @graph.remove_edge(@edge)
    @in_vertex.in_edges.should == {}
    @in_vertex.out_edges.should == {}    
  end
  
  it "should have an index" do
    @graph.index.should be_an Index
  end
  
  it "should clear itself" do
    @graph.clear
    @graph.vertices.length.should == 0
    @graph.edges.length.should == 0    
  end
  
  it "should loop through a hash of vertices" do
    @graph.vertices.each_pair do |k,v|
      v.should be_a Vertex
    end
  end
  
  it "should loop through a hash of edges" do
    @graph.edges.each_pair do |k,v|
      v.should be_a Edge
    end
  end
  
  it "should get a vertex" do
    @graph.vertices[2].should == @in_vertex
  end
end