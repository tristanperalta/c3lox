module scanner;
import std::io;

struct Scanner {
  String code;
  usz start;
  usz current;
  int line;
}

enum TokenType {
  // Single-character tokens.
  LEFT_PAREN, RIGHT_PAREN,
  LEFT_BRACE, RIGHT_BRACE,
  COMMA, DOT, MINUS, PLUS,
  SEMICOLON, SLASH, STAR,
  // One or two character tokens.
  BANG, BANG_EQUAL,
  EQUAL, EQUAL_EQUAL,
  GREATER, GREATER_EQUAL,
  LESS, LESS_EQUAL,
  // Literals.
  IDENTIFIER, STRING, NUMBER,
  // Keywords.
  AND, CLASS, ELSE, FALSE,
  FOR, FUN, IF, NIL, OR,
  PRINT, RETURN, SUPER, THIS,
  TRUE, VAR, WHILE,

  ERROR, EOF
}

struct Token (Printable) {
  TokenType type;
  String data;
  int line;
}

fn usz? Token.to_format(&self, Formatter* f) @dynamic {
  return f.printf("%s", self.type);
}

fn Scanner new(String source) {
  Scanner scanner;
  scanner.init(source);
  return scanner;
}

fn void Scanner.init(&self, String source) {
  self.code = source;
  self.start = 0;
  self.current = 0;
  self.line = 1;
}

fn Token Scanner.scan_token(&self) {
  Token token;

  self.start = self.current;

  if (self.is_at_end()) return self.make_token(EOF);

  Char32? c = self.advance();
  io::printfn("char: %s", c!!);

  switch (c!!) {
    case '(' : return self.make_token(LEFT_PAREN);
    case ')' : return self.make_token(RIGHT_PAREN);
    case '{' : return self.make_token(LEFT_BRACE);
    case '}' : return self.make_token(RIGHT_BRACE);
    case ';' : return self.make_token(SEMICOLON);
    case ',' : return self.make_token(COMMA);
    case '.' : return self.make_token(DOT);
    case '-' : return self.make_token(MINUS);
    case '+' : return self.make_token(PLUS);
    case '/' : return self.make_token(SLASH);
    case '*' : return self.make_token(STAR);
    case '!' :
      return self.make_token(self.match('=') ? BANG_EQUAL : BANG);
  }

  return self.error_token("Unexpected character.");
}

fn bool Scanner.is_at_end(&self) {
  return self.current >= self.code.len;
}

fn Token Scanner.make_token(&self, TokenType type) {
  Token token;
  token.type = type;
  token.data = self.code[self.start..self.start];
  token.line = self.line;

  return token;
}

fn Token Scanner.error_token(&self, String message) {
  Token token;
  token.type = ERROR;
  token.data = message;
  token.line = self.line;
  return token;
}

fn Char32? Scanner.get_current(&self) {
  usz len = self.code.len;
  usz current = self.current;
  usz read = (len - current < 4 ? len - current : 4);
  Char32 res = conv::utf8_to_char32(&self.code[current], &read)!;
  return res;
}

fn Char32? Scanner.advance(&self) {
  usz len = self.code.len;
  usz current = self.current;
  usz read = (len - current < 4 ? len - current : 4);
  Char32 res = conv::utf8_to_char32(&self.code[current], &read)!;
  self.current += read;
  return res;
}

fn bool Scanner.match(&self, Char32 expected) {
  if (self.is_at_end()) return false;
  if (self.get_current()!! != expected) return false;
  return true;
}
