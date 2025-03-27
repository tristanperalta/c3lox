module c3lox;

import std::io;
import common;
import value;
import debug;

fn int main() {
  Chunk chunk = common::new_chunk();
  defer chunk.free();

  uint x = (uint)OpCode.OP_RETURN;
  int constant = chunk.add_constant(1.0);

  io::printfn("capacity: %s, count: %s", chunk.capacity, chunk.count);
  chunk.write(x, 1);
  io::printfn("capacity: %s, count: %s", chunk.capacity, chunk.count);
  chunk.write(OpCode.OP_CONSTANT, 333);
  io::printfn("capacity: %s, count: %s", chunk.capacity, chunk.count);
  chunk.write((uint)constant, 3);

  chunk.disassemble("my program");

  return 0;
}
