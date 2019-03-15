
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
local:dispatch($node/*)
};

declare function local:node($node as node()) {
let $nl := "&#10;"
return
  (concat('"name:" "', $node/@TEXT, '"', $nl, 
  
  '"children": ['),
  local:dispatch($node/*)
  )

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

('var data = {{',
  local:dispatch($root)
)
