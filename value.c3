module value;

import common;

def Value = double;

struct ValueArray {
  int capacity;
  int count;
  Value* values;
}

fn void ValueArray.init(&self) {
  self.values = null;
  self.capacity = 0;
  self.count = 0;
}

fn void ValueArray.write(&self, Value value) {
  if (self.capacity < self.count + 1) {
    int old_capacity = self.capacity;
    self.capacity = common::@grow_capacity(old_capacity);
    self.values = common::reallocate(self.values, Value.sizeof * self.capacity);
  }

  self.values[self.count] = value;
  self.count++;
}

fn void ValueArray.free(&self) {
  free(self.values);
  self.init();
}
