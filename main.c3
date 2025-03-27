module c3lox;

import std::io;
import common;
import value;
import debug;

fn int main() {
  Chunk chunk = common::new_chunk();
  uint x = (uint)OpCode.OP_RETURN;

  int constant = chunk.add_constant(1.0);

  io::printfn("capacity: %s, count: %s", chunk.capacity, chunk.count);
  chunk.write(x);
  io::printfn("capacity: %s, count: %s", chunk.capacity, chunk.count);
  chunk.write(OpCode.OP_CONSTANT);
  io::printfn("capacity: %s, count: %s", chunk.capacity, chunk.count);
  chunk.write((uint)constant);

  chunk.disassemble("my program");
  chunk.free();

  return 0;
}
