declare function local:dispatch($nodes as node()*) as item()* {
    for $node in $nodes
    return typeswitch($node)
        case text() return $node
        case comment() return $node
        case element(map) return local:map($node)
        case element(node) return local:node($node)
        case element(edge) return local:edge($node)
        case element(font) return local:font($node)
        case element(hook) return local:hook($node)
        default return local:passthru($node)
};

declare function local:map($node as node()) {
  <map>{local:dispatch($node/*)}</map>
};

declare function local:node($node as node()) {
  <node>
  {$node/@TEXT}
  {local:dispatch($node/*)}
  </node>
};

declare function local:edge($node as node()) {
  local:dispatch($node/*)
};


declare function local:font($node as node()) {
  local:dispatch($node/*)
};

declare function local:hook($node as node()) {
  local:dispatch($node/*)
};

declare function local:passthru($nodes as node()*) as item()* {
    for $node in $nodes/node() return local:dispatch($node)
};

let $doc := doc('../data/graph-use-cases.xml')

let $root := $doc

return
<results>
  {local:dispatch($root)}
</results>