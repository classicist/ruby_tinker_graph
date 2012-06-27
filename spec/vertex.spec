require "vertex"

describe Vertex do
  before(:each) do
    @vert = Vertex.new(1, "index")
    @edge = "edge"
  end
  
  it "should have out_edges" do
    @vert.out_edges[2] = @edge
    @vert.out_edges.should == {2 => @edge}
  end
  
  it "should have in_edges" do
    @vert.in_edges[3] = @edge
    @vert.in_edges.should == {3 => @edge}
  end
end