; Scopes
; ======

(class_definition) @local.scope

(method_definition) @local.scope

(annotation_directive) @local.scope

(subannotation_directive) @local.scope

(packed_switch_directive) @local.scope

(sparse_switch_directive) @local.scope

(array_data_directive) @local.scope

(expression) @local.scope

; Definitions
; ===========

(class_directive
  (class_identifier) @local.definition.type)

(annotation_directive
  (class_identifier) @local.definition.type)

(method_definition
  (method_signature (method_identifier) @local.definition.function))

(field_definition
  (field_identifier) @local.definition.field
  (field_type) @local.definition.associated)

((field_definition
  (access_modifiers) @_mod
  (field_identifier) @local.definition.constant)
  (#match? @_mod "enum"))

(enum_reference
  (field_identifier) @local.definition.constant)

(annotation_key) @local.definition.field

(param_identifier) @local.definition.parameter

(local_directive
  (identifier) @local.definition.variable)

; References
; ==========

[
  (identifier)
  (class_identifier)
  (label)
  (jmp_label)
] @local.reference
