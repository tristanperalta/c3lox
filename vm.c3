module vm;

import common;
import std::io;

struct Vm {
  Chunk *chunk;
  uint *ip;
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
  self.ip = self.chunk.code;
  return self.run();
}

fn InterpretResult Vm.run(&self) {
  foreach (&instruction : self.chunk.code) {
    io::printfn("%s", instruction);
  }
  return InterpretResult.OK;
}
