module TinkerGraph
  require 'set'
  
  class Element
    include Comparable
    attr_reader :id, :properties
    
    def initialize(id, index)
      @id = id
      @index = index
      @properties = {"id" => id}
    end
    
    def set_property(name, value=nil)
      unless name == "id"
        @index.remove(name, @properties[name], self)
        @properties[name] = value
        @index.put(name, value, self)
      end
    end
    
    def remove_property(name)
       unless name == "id"
         @properties.delete(name)
         @index.remove(name, @properties[name], self)
       end
    end
    
    def property_value(name)
      @properties[name]
    end
    
    def property_keys
      Set.new( @properties.keys )
    end
    
    def clear
      @properties = {"id" => id}
    end
    
    def <=>(other)
      case 
        when self.id.to_i >  other.id.to_i then 1
        when self.id.to_i == other.id.to_i then 0
        when self.id.to_i <  other.id.to_i then -1                
      end
    end
  end
end