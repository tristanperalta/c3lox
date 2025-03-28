module c3lox;

import std::io;
import common;
import value;
import debug;
import vm;

fn int main() {
  Chunk chunk = common::new_chunk();
  defer chunk.free();



  int constant = (int)chunk.add_constant(200.0);
  chunk.write(OpCode.CONSTANT, 333);
  chunk.write((uint)constant, 3);

  int constant2 = (int)chunk.add_constant(3.3);
  chunk.write(OpCode.CONSTANT, 333);
  chunk.write((uint)constant2, 3);

  chunk.write(OpCode.ADD, 4);

  chunk.write((uint)OpCode.RETURN, 1);

  chunk.disassemble("my program");

  Vm vm;

  vm.init();
  vm.interpret(&chunk);

  return 0;
}
