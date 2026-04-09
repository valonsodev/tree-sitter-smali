; Types
; =====

(class_identifier
  (identifier) @type)

(primitive_type) @type.builtin

; Highlight well-known Android/Java framework packages as builtins
((class_identifier
   . (identifier) @_first @type.builtin
   (identifier) @type.builtin)
  (#any-of? @_first "android" "dalvik" "java" "kotlinx" "kotlin"))

((class_identifier
   . (identifier) @_first @type.builtin
   . (identifier) @_second @type.builtin
   (identifier) @type.builtin)
  (#eq? @_first "com")
  (#any-of? @_second "android" "google"))

; Methods
; =======

(method_definition
  (method_signature (method_identifier) @function))

(expression
  (opcode) @_invoke
  (body
    (full_method_signature
      (method_signature (method_identifier) @function.call)))
  (#match? @_invoke "^invoke"))

(method_handle
  (full_method_signature
    (method_signature (method_identifier) @function.call)))

(custom_invoke
  . (identifier) @function.call
  (method_signature (method_identifier) @function.call))

(annotation_value
  (body
    (method_signature (method_identifier) @function.call)))

(annotation_value
  (body
    (full_method_signature
      (method_signature (method_identifier) @function.call))))

(field_definition
  (body
    (method_signature (method_identifier) @function.call)))

(field_definition
  (body
    (full_method_signature
      (method_signature (method_identifier) @function.call))))

; Constructors
((method_identifier) @constructor
  (#any-of? @constructor "<init>" "<clinit>"))

"constructor" @constructor

; Fields
; ======

[
  (field_identifier)
  (annotation_key)
] @property

; SCREAMING_SNAKE_CASE fields are constants
((field_identifier) @constant
  (#match? @constant "^[A-Z][A-Z_0-9]*$"))

; Variables & Registers
; =====================

(variable) @variable.builtin

(local_directive
  (identifier) @variable)

; Parameters
; ==========

(parameter) @variable.parameter
(param_identifier) @variable.parameter

; Labels
; ======

[
  (label)
  (jmp_label)
] @label

; Opcodes
; =======

(opcode) @keyword.operator

((opcode) @keyword.return
  (#match? @keyword.return "^return"))

((opcode) @keyword.conditional
  (#match? @keyword.conditional "^if"))

((opcode) @keyword.conditional
  (#match? @keyword.conditional "^cmp"))

((opcode) @keyword.exception
  (#match? @keyword.exception "^throw"))

((opcode) @comment
  (#eq? @comment "nop"))

; Operators
; =========

[
  "="
  ".."
] @operator

; Keywords - Directives
; =====================

[
  ".class"
  ".super"
  ".implements"
  ".field"
  ".end field"
  ".annotation"
  ".end annotation"
  ".subannotation"
  ".end subannotation"
  ".param"
  ".end param"
  ".parameter"
  ".end parameter"
  ".line"
  ".locals"
  ".local"
  ".end local"
  ".restart local"
  ".registers"
  ".packed-switch"
  ".end packed-switch"
  ".sparse-switch"
  ".end sparse-switch"
  ".array-data"
  ".end array-data"
  ".enum"
  (prologue_directive)
  (epilogue_directive)
] @keyword

[
  ".source"
] @keyword.import

[
  ".method"
  ".end method"
] @keyword.function

[
  ".catch"
  ".catchall"
] @keyword.exception

; Literals
; ========

(string) @string
(source_directive (string "\"" _ @string.special.url "\""))
(escape_sequence) @string.escape

(character) @character

"L" @character.special

(number) @number

[
  (float)
  (NaN)
  (Infinity)
] @number.float

(boolean) @boolean

(null) @constant.builtin

; Misc
; ====

(annotation_visibility) @keyword.modifier

(access_modifier) @keyword.modifier

(array_type
  "[" @punctuation.special)

["{" "}"] @punctuation.bracket

["(" ")"] @punctuation.bracket

[
  "->"
  ","
  ":"
  ";"
  "@"
  "/"
] @punctuation.delimiter

(line_directive (number) @comment @markup.underline)

; Comments
; ========

(comment) @comment

(class_definition
  (comment) @comment.documentation)

; Errors
; ======

(ERROR) @error
