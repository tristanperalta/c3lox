module common;

import std::collections::list;

enum OpCode : uint {
  OP_RETURN
}

def Value = double;

struct Chunk {
  int count;
  int capacity;
  OpCode* code;
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
}

fn void Chunk.write(&self, OpCode byte) {
  if (self.capacity < self.count + 1) {
    int old_capacity = self.capacity;
    self.capacity = @grow_capacity(old_capacity);
    self.code = reallocate(self.code, OpCode.sizeof * self.capacity);
  }
  self.code[self.count] = byte;
  self.count++;
}

fn void Chunk.free(&self) {
  free(self.code);
  self.init();
}

fn int Chunk.add_constant(&self, Value value) {
  return 1;
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
