module c3lox;

import std::io;
import common;
import value;
import debug;
import vm;
import scanner;

fn int main(String[] args) {
  io::printfn("%s", args);

  if (args.len == 1) {
    repl();
  } else if (args.len == 2) {
    runFile(args[1]);
  } else {
    io::printfn("usage");
    return 1;
  }

  return 0;
}

fn void repl() {
  io::printf("prompt> ");
  String? line = io::treadline();
  if (catch excuse = line) {
    io::printfn("failed");
  }
  interpret(line!!);
}

fn void runFile(String filename) {
  io::printfn("running file");
}

fn InterpretResult interpret(String source) {
  compile(source);
  return InterpretResult.OK;
}

fn void compile(String source) {
  scanner::Scanner s = scanner::new(source);
  Token token = s.scan_token();
  io::printfn(":%s", token);
}
