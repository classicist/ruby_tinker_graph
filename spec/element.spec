require 'element'
require 'set'

describe Element do
  before(:each) do
    @element = Element.new("1", MockIndex.new)
    @element.set_property("hello", "joe")
  end
  
  it "should get and set dynamic properties" do
    @element.property_value("hello").should == "joe"
  end
  
  it "should get a set of all property keys" do
    @element.property_keys.should == Set.new(["id", "hello"])    
  end
  
  it "should have an id" do
    @element.property_value("id").should == "1"    
  end
  
  it "should not be possible to change the id" do
     @element.set_property("id", 2)
     @element.remove_property("id")         
     @element.property_value("id").should == "1"    
  end
  
  it "should remove a property" do
     @element.set_property("moo", "cow")
     @element.remove_property("moo")              
     @element.property_value("moo").should == nil        
  end
end

class MockIndex
  def method_missing(*args)
    return *args
  end
end