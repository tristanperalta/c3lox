module debug;

import common;
import std::io;


fn void Chunk.disassemble(&self, String name) {
  io::printfn("== %s ==", name);

  for (int offset = 0; offset < self.count;) {
    offset = self.disassemble_instruction(offset);
  }
}

fn int Chunk.disassemble_instruction(&self, int offset) {
  io::printf("%s ", offset);

  OpCode instruction = self.code[offset];
  switch (instruction) {
    case OpCode.OP_RETURN:
      return simple_instruction(instruction.description, offset);
    default:
      io::printf("Unknown opcode %d\n", instruction);
      return offset + 1;
  }
}

fn int simple_instruction(String name, int offset) {
  io::printfn("%s", name);
  return offset + 1;
}
