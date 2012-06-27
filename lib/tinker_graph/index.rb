module TinkerGraph  
  class Index
    require 'set'
  
    attr_accessor :index_all, :index_keys
    
    def initialize()
      @index = {}
      @index_all = true
      @index_keys = Set.new
    end
    
    def put(key, value, element)
      return unless (@index_all || @index_keys.member?(key) )
      
      if @index[key] && @index[key][value]
        @index[key][value].add(element)
      elsif @index[key]
        @index[key][value] = Set.new([element])
      else
        @index[key] = {value => Set.new([element])}
      end
      nil
    end
    
    def get(key, value)
      @index[key] && @index[key][value] || Set.new
    end
    
    def remove(key, value, element)
      if @index[key] && @index[key][value]
        @index[key][value].delete(element)
        @index[key].delete(value) if @index[key][value].length == 0
      end
      nil
    end
    
    def add_index_key(key)
      @index_keys.add(key)
    end
    
    def remove_index_key(key)
      @index_keys.delete(key)
    end
    
    def to_s
      @index.to_s
    end
  end
end