(comment) @comment

(string) @string

[
  (integer)
  (float)
] @number

(boolean) @boolean

(none) @constant.builtin

; Bare identifiers fall back to @property: most themes leave @variable at body colour.
(identifier) @variable @property

(member_expression
  property: (identifier) @property)

(call_expression
  function: (identifier) @function)

(filter_expression
  name: (identifier) @function)

(test_expression
  name: (identifier) @function)

(keyword_argument
  key: (identifier) @property)

(pair
  key: (identifier) @property)

[
  "{{" "{{-" "{{~" "}}" "-}}" "~}}"
  "{%" "{%-" "{%~" "{%+" "%}" "-%}" "~%}" "+%}"
  "{#" "{#-" "{#~" "#}" "-#}" "~#}"
] @keyword

["(" ")" "[" "]" "{" "}"] @punctuation.bracket

["," "." "|" "~"] @punctuation.delimiter

[
  "+" "-" "*" "/" "//" "%" "**"
  "==" "!=" "<" ">" "<=" ">=" "===" "!=="
  "?" "??" "?." ":" "="
  "b-and" "b-or" "b-xor"
] @operator

[
  "if" "elif" "elseif" "else" "endif"
  "for" "in" "endfor" "recursive"
  "block" "endblock" "extends"
  "macro" "endmacro" "call" "endcall"
  "filter" "endfilter" "raw" "endraw" "verbatim" "endverbatim"
  "set" "endset" "with" "endwith"
  "include" "import" "from" "as"
  "autoescape" "endautoescape"
  "do" "is" "not" "and" "or"
  "ignore" "missing" "scoped" "context" "without"
] @keyword
