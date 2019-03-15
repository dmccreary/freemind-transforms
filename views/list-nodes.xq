let $doc := doc('../data/graph-use-cases.xml')

let $nodes := $doc//node

return
<results>
  <node-count>{count($nodes)}</node-count>
  {for $node in $nodes
   return
      <node>{$node/@TEXT/string()}</node>
   }
</results>