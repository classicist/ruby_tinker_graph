module TinkerGraph
  class GraphMLTokens 
    GRAPHML = "graphml"
    XMLNS = "xmlns"
    GRAPHML_XMLNS = "http://graphml.graphdrawing.org/xmlns"
    G = "G"
    EDGEDEFAULT = "edgedefault"
    DIRECTED = "directed"
    KEY = "key"
    FOR = "for"
    ID = "id"
    ATTR_NAME = "attr.name"
    ATTR_TYPE = "attr.type"
    GRAPH = "graph"
    NODE = "node"
    EDGE = "edge"
    SOURCE = "source"
    TARGET = "target"
    DATA = "data"
    LABEL = "label"
    STRING = "string"
    FLOAT = "float"
    BOOLEAN = "boolean"
    INT = "int"
    VERTEX_TYPES = [{"name" => STRING}, {"age" => INT}, {"lang" => STRING},]
    EDGE_TYPES = [{"weight" => FLOAT}]
  end
end