module common;

import std::collections::list;
import value;

enum OpCode : inline uint (String description) {
  CONSTANT = "OP_CONSTANT",
  ADD = "ADD",
  SUBTRACT = "SUBTRACT",
  MULTIPLY = "MULTIPLY",
  DIVIDE = "DIVIDE",
  NEGATE = "NEGATE",
  RETURN = "OP_RETURN",
}

alias Value = double;
alias Code = List{ uint };
alias Values = List{ Value };
alias Lines = List{ int };

struct Chunk {
  Code code;
  Values constants;
  Lines lines;
}

fn Chunk new_chunk() {
  Chunk chunk;
  chunk.init();

  return chunk;
}

fn void Chunk.init(&self) {
  self.code.tinit();
  self.constants.tinit();
  self.lines.tinit();
}

fn void Chunk.write(&self, uint byte, int line) {
  self.code.push(byte);
  self.lines.push(line);
}

fn void Chunk.free(&self) {
  self.code.free();
  self.lines.free();
  self.constants.free();

  self.init();
}

fn usz Chunk.add_constant(&self, Value value) {
  self.constants.push(value);
  return self.constants.len() - 1;
}

macro @grow_capacity(#capacity) {
  return ((#capacity) < 8 ? 8 : (#capacity) * 2);
}

fn void* reallocate(void* pointer, usz new_size) {
  if (new_size == 0) {
    free(pointer);
    return null;
  }

  void* result = realloc(pointer, new_size);
  return result;
}
