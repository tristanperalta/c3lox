module c3lox;

import std::io;
import common;
import value;
import debug;
import vm;

fn int main() {
  Chunk chunk = common::new_chunk();
  defer chunk.free();

  uint x = (uint)OpCode.RETURN;
  int constant = chunk.add_constant(200.0);

  chunk.write(x, 1);
  chunk.write(OpCode.CONSTANT, 333);
  chunk.write((uint)constant, 3);

  chunk.disassemble("my program");

  Vm vm;

  vm.init();
  vm.interpret(&chunk);

  return 0;
}
