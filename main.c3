module c3lox;

import std::io;
import common;
import debug;

fn int main() {
  Chunk chunk = common::new_chunk();
  OpCode x = OpCode.OP_RETURN;
  io::printfn("capacity: %s, count: %s", chunk.capacity, chunk.count);
  chunk.write(x);
  io::printfn("capacity: %s, count: %s", chunk.capacity, chunk.count);
  chunk.write(x);
  io::printfn("capacity: %s, count: %s", chunk.capacity, chunk.count);
  chunk.write(x);
  io::printfn("capacity: %s, count: %s", chunk.capacity, chunk.count);
  chunk.write(x);
  io::printfn("capacity: %s, count: %s", chunk.capacity, chunk.count);
  chunk.write(x);
  io::printfn("capacity: %s, count: %s", chunk.capacity, chunk.count);
  chunk.write(x);
  io::printfn("capacity: %s, count: %s", chunk.capacity, chunk.count);
  chunk.write(x);
  io::printfn("capacity: %s, count: %s", chunk.capacity, chunk.count);
  chunk.write(x);
  io::printfn("capacity: %s, count: %s", chunk.capacity, chunk.count);
  chunk.write(x);
  io::printfn("capacity: %s, count: %s", chunk.capacity, chunk.count);
  chunk.write(x);
  io::printfn("capacity: %s, count: %s", chunk.capacity, chunk.count);
  chunk.write(OpCode.OP_CONSTANT);
  io::printfn("capacity: %s, count: %s", chunk.capacity, chunk.count);

  io::printfn("code: %s", chunk.code[0]);
  chunk.disassemble("my program");
  chunk.free();

  return 0;
}
