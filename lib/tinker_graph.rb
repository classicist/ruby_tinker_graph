$:.unshift(File.dirname(__FILE__) + "/tinker_graph") 
module TinkerGraph
  require 'element'
  require 'edge'
  require 'vertex'  
  require 'index'
  require 'graph'
  require 'graphMLWriter'  
  require 'graphMLReader'
  require 'graphVizWriter'
  VERSION = '0.1'
end