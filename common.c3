module common;

import std::collections::list;
import value;

enum OpCode : inline uint (String description) {
  OP_CONSTANT = "OP_CONSTANT",
  OP_RETURN = "OP_RETURN",
}

struct Chunk {
  int count;
  int capacity;
  uint *code;
  int *lines;
  ValueArray constants;
}

fn Chunk new_chunk() {
  Chunk chunk;
  chunk.init();

  return chunk;
}

fn void Chunk.init(&self) {
  self.count = 0;
  self.capacity = 0;
  self.code = null;
  self.lines = null;
  self.constants.init();
}

fn void Chunk.write(&self, uint byte, int line) {
  if (self.capacity < self.count + 1) {
    int old_capacity = self.capacity;
    self.capacity = @grow_capacity(old_capacity);
    self.code = reallocate(self.code, uint.sizeof * self.capacity);
    self.lines = reallocate(self.lines, int.sizeof * self.capacity);
  }
  self.code[self.count] = byte;
  self.lines[self.count] = line;
  self.count++;
}

fn void Chunk.free(&self) {
  self.constants.free();
  free(self.code);
  free(self.lines);
  self.init();
}

fn int Chunk.add_constant(&self, Value value) {
  self.constants.write(value);
  return self.constants.count - 1;
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
