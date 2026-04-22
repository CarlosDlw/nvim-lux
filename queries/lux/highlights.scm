; Tree-sitter highlight queries for Lux
; These queries require a compiled tree-sitter-lux parser.
; See: https://tree-sitter.github.io/tree-sitter/creating-parsers
;
; The parser grammar source lives in grammar/ (LuxParser.g4 / LuxLexer.g4).
; Until an official tree-sitter parser is published, nvim-lux falls back
; to the Vim regex syntax in syntax/lux.vim.

; ── Keywords ──────────────────────────────────────────────────────────────────
[
  "if" "else" "for" "in" "loop" "while" "do"
  "break" "continue" "switch" "case" "default"
  "ret" "defer"
] @keyword.control

[
  "namespace" "use" "struct" "union" "enum"
  "fn" "type" "extend" "extern" "auto"
] @keyword.declaration

[
  "as" "is" "sizeof" "typeof" "spawn" "await" "lock"
] @keyword.operator

[
  "try" "catch" "finally" "throw"
] @keyword.exception

; ── Collection type keywords ──────────────────────────────────────────────────
["vec" "map" "set" "tuple"] @type.builtin

; ── Primitive types ───────────────────────────────────────────────────────────
(primitive_type) @type.builtin

; ── Literals ──────────────────────────────────────────────────────────────────
(string_literal)     @string
(c_string_literal)   @string
(char_literal)       @character
(escape_sequence)    @string.escape
(integer_literal)    @number
(float_literal)      @number.float
(bool_literal)       @boolean
(null_literal)       @constant.builtin

; ── Comments ──────────────────────────────────────────────────────────────────
(line_comment)       @comment
(block_comment)      @comment
(doc_comment)        @comment.documentation

; ── Preprocessor ──────────────────────────────────────────────────────────────
(include_directive)  @preproc

; ── Declarations ──────────────────────────────────────────────────────────────
(struct_decl  name: (identifier) @type)
(enum_decl    name: (identifier) @type)
(union_decl   name: (identifier) @type)
(extend_decl  name: (identifier) @type)

(function_decl name: (identifier) @function)
(method_decl   name: (identifier) @function.method)

(param_decl    name: (identifier) @variable.parameter)

; ── Expressions ───────────────────────────────────────────────────────────────
(call_expr     function: (identifier) @function.call)
(method_call   method:   (identifier) @function.method.call)

(identifier) @variable

; ── Namespace access ──────────────────────────────────────────────────────────
"::" @punctuation.delimiter

; ── Operators ─────────────────────────────────────────────────────────────────
[
  "+" "-" "*" "/" "%" "&" "|" "^" "~"
  "==" "!=" "<" "<=" ">" ">=" "&&" "||" "!"
  "+=" "-=" "*=" "/=" "%=" "&=" "|=" "^=" "<<=" ">>="
  "->" "??" "..." ".." "..=" "?" "="
] @operator

; ── Punctuation ───────────────────────────────────────────────────────────────
["(" ")" "{" "}" "[" "]"] @punctuation.bracket
["," ";" ":"]              @punctuation.delimiter
