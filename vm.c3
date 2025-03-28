module vm;

import common;
import std::io;

struct Vm {
  Chunk *chunk;
  uint ip;
}

enum InterpretResult {
  OK,
  COMPILE_ERROR,
  RUNTIME_ERROR
}

fn void Vm.init(&self) {
  
}

fn void Vm.free(&self) {

}

fn InterpretResult Vm.interpret(&self, Chunk *chunk) {
  self.chunk = chunk;
  self.ip = 0;
  return self.run();
}

fn InterpretResult Vm.run(&self) {
  for (;;) {
    uint instruction;
    switch ( instruction = self.chunk.code[self.ip] ) {
      case OpCode.RETURN:
        return InterpretResult.OK;
    }
    self.ip++;
  }
}
