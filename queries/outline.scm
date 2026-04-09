(class_definition
  (class_directive
    ".class" @context
    (class_identifier) @name)) @item

(field_definition
  ".field" @context
  (field_identifier) @name
  (field_type) @context.extra) @item

(method_definition
  ".method" @context
  (method_signature
    (method_identifier) @name
    (parameters) @context.extra
    (_) @context.extra)) @item
