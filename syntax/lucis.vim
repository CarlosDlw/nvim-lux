" Vim syntax file for the lucis language (.lc)
" Maintainer:  nvim-lucis
" Language:    lucis

if exists("b:current_syntax")
  finish
endif

" ── Comments ──────────────────────────────────────────────────────────────────
syn keyword lucisTodo    TODO FIXME HACK NOTE XXX contained
syn match   lucisComment "//.*$"          contains=lucisTodo
syn region  lucisDocComment start="/\*\*" end="\*/" contains=lucisDocTag,lucisTodo
syn region  lucisBlockComment start="/\*" end="\*/" contains=lucisTodo
hi def link lucisTodo         Todo
hi def link lucisComment      Comment
hi def link lucisDocComment   SpecialComment
hi def link lucisBlockComment Comment

" ── Doc tags inside /** ... */ ─────────────────────────────────────────────
syn match lucisDocTag "@\(param\|property\|field\|returns\?\|type\|throws\|brief\|deprecated\|version\|author\|see\|since\|todo\|example\|remarks\|note\|warning\|private\|public\|protected\|internal\|struct\|namespace\)\b" contained
hi def link lucisDocTag SpecialComment

" ── Preprocessor ─────────────────────────────────────────────────────────────
syn match lucisInclude "#include\s*<[^>]*>"
syn match lucisInclude "#include\s*\"[^\"]*\""
hi def link lucisInclude PreProc

" ── Strings ──────────────────────────────────────────────────────────────────
syn region lucisCString  start=/c"/ end=/"/ skip=/\\./ contains=lucisEscape
syn region lucisString   start=/"/ end=/"/ skip=/\\./ contains=lucisEscape oneline
syn match  lucisChar     /'[^'\\]'\|'\\.'/
syn match  lucisEscape   /\\[nrtabfv0\\"'x]/ contained
syn match  lucisEscape   /\\x[0-9a-fA-F][0-9a-fA-F]/ contained
hi def link lucisCString  String
hi def link lucisString   String
hi def link lucisChar     Character
hi def link lucisEscape   SpecialChar

" ── Numbers ──────────────────────────────────────────────────────────────────
syn match lucisHexLit   /\<0[xX][0-9a-fA-F]\+\>/
syn match lucisOctLit   /\<0[oO][0-7]\+\>/
syn match lucisBinLit   /\<0[bB][01]\+\>/
syn match lucisFloat    /\<[0-9]\+\.[0-9]\+\([eE][+-]\?[0-9]\+\)\?\>/
syn match lucisFloat    /\<[0-9]\+[eE][+-]\?[0-9]\+\>/
syn match lucisInt      /\<[0-9]\+\>/
hi def link lucisHexLit  Number
hi def link lucisOctLit  Number
hi def link lucisBinLit  Number
hi def link lucisFloat   Float
hi def link lucisInt     Number

" ── Control keywords ─────────────────────────────────────────────────────────
syn keyword lucisControl
  \ if else for in loop while do break continue switch case default
  \ ret defer
hi def link lucisControl Keyword

" ── Declaration keywords ─────────────────────────────────────────────────────
syn keyword lucisDecl namespace use struct union enum fn type extend extern auto
hi def link lucisDecl StorageClass

" ── Collection type keywords ─────────────────────────────────────────────────
syn keyword lucisCollect vec map set tuple
hi def link lucisCollect Type

" ── Operator keywords ────────────────────────────────────────────────────────
syn keyword lucisOpKw as is sizeof typeof spawn await lock
hi def link lucisOpKw Operator

" ── Error handling keywords ───────────────────────────────────────────────────
syn keyword lucisError try catch finally throw
hi def link lucisError Exception

" ── Primitive types ──────────────────────────────────────────────────────────
syn keyword lucisType
  \ int1 int8 int16 int32 int64 int128 intinf isize
  \ uint1 uint8 uint16 uint32 uint64 uint128 usize
  \ float32 float64 float80 float128 double
  \ bool char void string cstring
hi def link lucisType Type

" ── Constants & builtins ─────────────────────────────────────────────────────
syn keyword lucisConst true false null
syn keyword lucisSelf  self
hi def link lucisConst  Boolean
hi def link lucisSelf   Special

" ── Builtin functions ────────────────────────────────────────────────────────
syn keyword lucisBuiltin
  \ exit panic assert assertMsg unreachable
  \ toString toInt toFloat toBool
  \ cstr fromCStr fromCStrLen
hi def link lucisBuiltin Special

" ── Type names (PascalCase identifiers) ──────────────────────────────────────
syn match lucisTypeName /\<[A-Z][A-Za-z0-9_]*\>/
hi def link lucisTypeName Type

" ── Namespace/scope access :: ────────────────────────────────────────────────
syn match lucisScope /::/
hi def link lucisScope Delimiter

" ── Function declarations — type name( ───────────────────────────────────────
" Catches patterns like:  int32 main(    User new(
syn match lucisFuncDecl /\([a-zA-Z_][a-zA-Z0-9_<>, *]*\)\s\+\([a-zA-Z_][a-zA-Z0-9_]*\)\s*(/me=e-1 contains=ALLBUT,lucisFuncDecl
  \ nextgroup=lucisFuncName
syn match lucisFuncName /\<[a-zA-Z_][a-zA-Z0-9_]*\>\ze\s*(/
hi def link lucisFuncName Function

" ── Operators ────────────────────────────────────────────────────────────────
syn match lucisOp /+=\|-=\|\*=\|\/=\|%=\|&=\||=\|\^=\|<<=\|>>=/
syn match lucisOp /==\|!=\|<=\|>=\|<<\|>>/
syn match lucisOp /&&\|||/
syn match lucisOp /[+\-*/%&|^~!<>]/
syn match lucisOp /->/
syn match lucisOp /\.\.\./
syn match lucisOp /\.\.\=/
syn match lucisOp /??/
syn match lucisOp /?/
syn match lucisOp /=\ze[^=]/
hi def link lucisOp Operator

let b:current_syntax = "lucis"
