; Class definitions

(class_directive
  (class_identifier) @name) @definition.class

; Method definitions

(method_definition
  (method_signature
    (method_identifier) @name)) @definition.method

; Field definitions

(field_definition
  (field_identifier) @name) @definition.field

; Annotation definitions (used as type markers)

(annotation_directive
  (class_identifier) @name) @definition.class

; Method calls

(expression
  (opcode) @_invoke
  (body
    (full_method_signature
      (method_signature
        (method_identifier) @name)))
  (#match? @_invoke "^invoke")) @reference.call

; Field references in expressions

(expression
  (body
    (full_method_signature
      (class_identifier) @name))) @reference.class

; Super class reference

(super_directive
  (class_identifier) @name) @reference.class

; Implements reference

(implements_directive
  (class_identifier) @name) @reference.implementation
