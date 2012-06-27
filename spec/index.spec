require 'index'
require 'set'


describe Index do
  before(:each) do
    @index = Index.new
    @data = "Hello World!"
    @index.put("key", "value", @data)
  end
  
  it "should index an element by property" do
   @index.get("key", "value").should == Set.new([@data])
  end
  
  it "should remove an indexed value" do
    @index.remove("key", "value", @data)
    @index.get("key", "value").should == Set.new
  end
  
  it "should remove an indexed value from several on the same key/value" do
    prize = "Vroom"
    @index.put("key", "value", prize)
    @index.remove("key", "value", @data)
    @index.get("key", "value").should == Set.new([prize])
  end
  
  it "should not index an invalid key when index_all is false" do
    index = Index.new
    vertex = "Hi Back"
    index.index_all = false
    index.put("key", "value", vertex)
    index.get("key", "value").should == Set.new
  end
  
  it "should index an valid key when index_all is false" do
    @index.add_index_key("key")
    @index.put("key", "value", @data)
    @index.get("key", "value").should == Set.new([@data])
  end
  
  it "should index a non-validated key when index_all is true" do
    @index.put("key", "value", @data)
    @index.get("key", "value").should == Set.new([@data])
  end
  
  it "should remove an index" do
    @index.remove_index_key("key")
    @index.index_keys.length.should == 0
  end
end