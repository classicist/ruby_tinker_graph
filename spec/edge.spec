require 'edge'

describe Edge do
  before(:each) do
   @id          = 1
   @in_vertex   = "in_vertex"
   @out_vertex  = "out_vertex"
   @label       = "mike"
   @index       = "index"
   @edge = Edge.new(@id, @out_vertex, @in_vertex, @label, @index)
  end

  it "should have a label" do
    @edge.label.should == @label
  end
  
  it "should have an in vertex" do
    @edge.in_vertex.should == @in_vertex
  end

  it "should have an out vertex" do
    @edge.out_vertex.should == @out_vertex
  end
  
  it "should equal another edge" do
    equal_edge = Edge.new(@id, "4", "3", "2", "1")
    @edge.should == equal_edge
  end
end