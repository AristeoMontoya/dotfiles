; extends

; Import path
(import_declaration
  (scoped_identifier
    scope: (_) @import.path.java)
  (#set! "priority" 200))

(annotation
  name: (identifier) @attribute.java)
(#set! @attribute.java priority 130)

(package_declaration
  (scoped_identifier) @package.java
  (#set! "priority" 130))

(
  (annotation
    name: (identifier) @_name
    arguments: (annotation_argument_list
      (string_literal
        (string_fragment) @path.param)))
  (#any-of? @_name
    "Path"
    "GetMapping"
  )
  (#match? @path.param "\\{[^}]+\\}")
)
