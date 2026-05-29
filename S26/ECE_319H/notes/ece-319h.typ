#import "@preview/noteworthy:0.3.0": *
#import "@preview/unify:0.7.1": *

#show: noteworthy.with(
  paper-size: "us-letter",
  font: "New Computer Modern",
  language: "EN",
  title: "ECE 319H Review",
  header-title: "ECE 319H",
  author: "Dawson Zhang",
  contact-details: "dawsonzhang@utexas",
  toc-title: "Table of Contents",
)

#show link: underline

// Reset the figure counter at each top-level heading
#show heading.where(level: 1): it => {
  counter(figure.where(kind: image)).update(0)
  it
}

// Number figures as <section>.<figure>
#set figure(numbering: n => {
  let h = counter(heading).get()
  numbering("1.1", h.first(), n)
})

#pagebreak()
= Pass by value vs. reference

```c
int(func int x) {
  return x + 1;
}

int main() {
  int var = 2;
  int result;
  result = func(var);
}
```

After running this code, ``` result``` is 3, but this code is still pass by value.

```c
int func2(int* x) {
  *x += 1;
  return *x;
}
```

In this snippet ```c int* x``` is an integer pointer, not a dereference.

= AAPCS Registers and Stack

+ Binding #sym.arrow improves the readability of your Assembly code by mapping
  a name to the offset of the stack

  ```asm
  y .equ 0
  z .equ 4
  ```

  offsets from the ```asm SP```. Remember that ```asm .equ``` just copy pastes the
  values

+ Allocation #sym.arrow ```asm SUB SP, SP, #8``` allocates 2 spaces in the stack

  ```asm
  MOVS R7, SP # Creates a frame pointer
  ```

+ Access

  ```asm
  LDR R1, [R7, #y]
  LDR R2, [R7, #z]
  ```

+ Deallocation

  ```arm
  BX LR
  ```

Everything on stack is 4 bytes. Both ```asm PUSH``` and ```asm POP``` work with 4 bytes.
If whatever you're putting on the stack is less than 4 bytes it will still take up 4 bytes
of space.

The ```asm SP``` points to the top of the stack. NOT the empty space.

```asm
PUSH{R2, R1, R7}
PUSH{R1, R2, R7}
```

Both instructions work the same. The position of the parameter doesn't matter. The
smaller register is mapped to the smallest address. Remember, "smallest register
smallest address."

= FIFO Practice Question

We want to build the FIFO from lab 8.

```c
#define MAX_SZ 32

struct fix_pt_t {
  uint8_t whole;
  uint8_t frac;
}; 

struct fix_pt_t FIFO[MAX_SZ];
uint32_t get, put;

uint8_t is_empty() {
  return get == put;
}

uint8_t is_full() {
  return (put + 1) % MAX_SZ == get;
}

void put_fifo(struct fix_pt_t a) {
  if(is_full()) return;
  FIFO[put] = a;
  put++;
  put %= 32;
}

struct fix_pt_t get_fifo(uint32_t index) {
  return FIFO[index];
}
```
