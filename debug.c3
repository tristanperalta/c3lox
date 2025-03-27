module debug;

import common;
import std::io;


fn void Chunk.disassemble(&self, String name) {
  io::printfn("== %s ==", name);

  for (int offset = 0; offset < self.code.len();) {
    offset = self.disassemble_instruction(offset);
  }
}

fn int Chunk.disassemble_instruction(&self, int offset) {
  if (offset > 0 &&
    self.lines.get(offset) == self.lines.get((usz)offset - 1)) {
    io::printf("    | ");
  } else {
    io::printf("%4d ", self.lines.get(offset));
  }

  uint instruction = self.code[offset];
  switch (instruction) {
    case OpCode.RETURN:
      return simple_instruction("OP_RETURN", offset);
    case OpCode.CONSTANT:
      return constant_instruction("OP_CONSTANT", self, offset);
    default:
      io::printf("Unknown opcode %d\n", instruction);
      return offset + 1;
  }
}

fn int simple_instruction(String name, int offset) {
  io::printfn("%s", name);
  return offset + 1;
}

fn int constant_instruction(String name, Chunk* chunk, int offset) {
  uint constant = chunk.code.get(offset);
  io::printfn("%-16s, %4d '%s'", name, constant, chunk.constants.get(constant));
  return offset + 2;
}
