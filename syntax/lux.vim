" Vim syntax file for the Lux language (.lx)
" Maintainer:  nvim-lux
" Language:    Lux

if exists("b:current_syntax")
  finish
endif

" ── Comments ──────────────────────────────────────────────────────────────────
syn keyword luxTodo    TODO FIXME HACK NOTE XXX contained
syn match   luxComment "//.*$"          contains=luxTodo
syn region  luxDocComment start="/\*\*" end="\*/" contains=luxDocTag,luxTodo
syn region  luxBlockComment start="/\*" end="\*/" contains=luxTodo
hi def link luxTodo         Todo
hi def link luxComment      Comment
hi def link luxDocComment   SpecialComment
hi def link luxBlockComment Comment

" ── Doc tags inside /** ... */ ─────────────────────────────────────────────
syn match luxDocTag "@\(param\|property\|field\|returns\?\|type\|throws\|brief\|deprecated\|version\|author\|see\|since\|todo\|example\|remarks\|note\|warning\|private\|public\|protected\|internal\|struct\|namespace\)\b" contained
hi def link luxDocTag SpecialComment

" ── Preprocessor ─────────────────────────────────────────────────────────────
syn match luxInclude "#include\s*<[^>]*>"
syn match luxInclude "#include\s*\"[^\"]*\""
hi def link luxInclude PreProc

" ── Strings ──────────────────────────────────────────────────────────────────
syn region luxCString  start=/c"/ end=/"/ skip=/\\./ contains=luxEscape
syn region luxString   start=/"/ end=/"/ skip=/\\./ contains=luxEscape oneline
syn match  luxChar     /'[^'\\]'\|'\\.'/
syn match  luxEscape   /\\[nrtabfv0\\"'x]/ contained
syn match  luxEscape   /\\x[0-9a-fA-F][0-9a-fA-F]/ contained
hi def link luxCString  String
hi def link luxString   String
hi def link luxChar     Character
hi def link luxEscape   SpecialChar

" ── Numbers ──────────────────────────────────────────────────────────────────
syn match luxHexLit   /\<0[xX][0-9a-fA-F]\+\>/
syn match luxOctLit   /\<0[oO][0-7]\+\>/
syn match luxBinLit   /\<0[bB][01]\+\>/
syn match luxFloat    /\<[0-9]\+\.[0-9]\+\([eE][+-]\?[0-9]\+\)\?\>/
syn match luxFloat    /\<[0-9]\+[eE][+-]\?[0-9]\+\>/
syn match luxInt      /\<[0-9]\+\>/
hi def link luxHexLit  Number
hi def link luxOctLit  Number
hi def link luxBinLit  Number
hi def link luxFloat   Float
hi def link luxInt     Number

" ── Control keywords ─────────────────────────────────────────────────────────
syn keyword luxControl
  \ if else for in loop while do break continue switch case default
  \ ret defer
hi def link luxControl Keyword

" ── Declaration keywords ─────────────────────────────────────────────────────
syn keyword luxDecl namespace use struct union enum fn type extend extern auto
hi def link luxDecl StorageClass

" ── Collection type keywords ─────────────────────────────────────────────────
syn keyword luxCollect vec map set tuple
hi def link luxCollect Type

" ── Operator keywords ────────────────────────────────────────────────────────
syn keyword luxOpKw as is sizeof typeof spawn await lock
hi def link luxOpKw Operator

" ── Error handling keywords ───────────────────────────────────────────────────
syn keyword luxError try catch finally throw
hi def link luxError Exception

" ── Primitive types ──────────────────────────────────────────────────────────
syn keyword luxType
  \ int1 int8 int16 int32 int64 int128 intinf isize
  \ uint1 uint8 uint16 uint32 uint64 uint128 usize
  \ float32 float64 float80 float128 double
  \ bool char void string cstring
hi def link luxType Type

" ── Constants & builtins ─────────────────────────────────────────────────────
syn keyword luxConst true false null
syn keyword luxSelf  self
hi def link luxConst  Boolean
hi def link luxSelf   Special

" ── Builtin functions ────────────────────────────────────────────────────────
syn keyword luxBuiltin
  \ exit panic assert assertMsg unreachable
  \ toString toInt toFloat toBool
  \ cstr fromCStr fromCStrLen
hi def link luxBuiltin Special

" ── Type names (PascalCase identifiers) ──────────────────────────────────────
syn match luxTypeName /\<[A-Z][A-Za-z0-9_]*\>/
hi def link luxTypeName Type

" ── Namespace/scope access :: ────────────────────────────────────────────────
syn match luxScope /::/
hi def link luxScope Delimiter

" ── Function declarations — type name( ───────────────────────────────────────
" Catches patterns like:  int32 main(    User new(
syn match luxFuncDecl /\([a-zA-Z_][a-zA-Z0-9_<>, *]*\)\s\+\([a-zA-Z_][a-zA-Z0-9_]*\)\s*(/me=e-1 contains=ALLBUT,luxFuncDecl
  \ nextgroup=luxFuncName
syn match luxFuncName /\<[a-zA-Z_][a-zA-Z0-9_]*\>\ze\s*(/
hi def link luxFuncName Function

" ── Operators ────────────────────────────────────────────────────────────────
syn match luxOp /+=\|-=\|\*=\|\/=\|%=\|&=\||=\|\^=\|<<=\|>>=/
syn match luxOp /==\|!=\|<=\|>=\|<<\|>>/
syn match luxOp /&&\|||/
syn match luxOp /[+\-*/%&|^~!<>]/
syn match luxOp /->/
syn match luxOp /\.\.\./
syn match luxOp /\.\.\=/
syn match luxOp /\?\?/
syn match luxOp /\?/
syn match luxOp /=\ze[^=]/
hi def link luxOp Operator

let b:current_syntax = "lux"
