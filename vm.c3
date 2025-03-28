module vm;

import common;
import std::io;
import std::collections::list;

enum InterpretResult {
  OK,
  COMPILE_ERROR,
  RUNTIME_ERROR
}

alias Stack = List { Value };

struct Vm {
  Chunk *chunk;
  usz ip;
  Stack stack;
}

fn void Vm.init(&self) {
  
}

fn void Vm.free(&self) {

}

fn void Vm.push(&self, Value value) {
  self.stack.push(value);
}

fn Value? Vm.pop(&self) {
  return self.stack.pop();
}

fn InterpretResult Vm.interpret(&self, Chunk *chunk) {
  self.chunk = chunk;
  self.ip = 0;
  int i = 0;
  io::printfn("increment post: %s", i++);
  io::printfn("post: %s", i);
  return self.run();
}

fn InterpretResult Vm.run(&self) {
  for (;;) {
    uint instruction;
    switch ( instruction = self.chunk.code.get(self.ip++) ) {
      case OpCode.ADD:
        Value b = self.pop()!!;
        Value a = self.pop()!!;
        self.push(a + b);
        io::printfn("inst: %s", "ADD");
        io::printfn("stack: %s", self.stack);
        io::printfn("ip: %s\n", self.ip);
        break;
      case OpCode.CONSTANT: {
        int index = self.chunk.code.get(self.ip++);
        Value constant = self.chunk.constants.get(index);
        self.push(constant);
        io::printfn("inst: %s", "CONSTANT");
        io::printfn("const: %s", self.chunk.constants);
        io::printfn("stack: %s", self.stack);
        io::printfn("ip: %s\n", self.ip);
        break;
      }
      case OpCode.RETURN:
        io::printfn("return ok");
        return InterpretResult.OK;
    }
  }
}
