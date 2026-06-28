# Direct-Mapped Cache Controller in Verilog

## Overview

This project implements a **Direct-Mapped Cache Controller** in Verilog. The cache sits between the CPU and the main memory to reduce memory access latency by storing recently accessed memory blocks.

The design includes:
- Address decoding
- Tag comparison
- Valid bit management
- Cache data storage
- Main memory interface
- FSM-based cache controller
- Word selection using offset bits

---

## Features

- Direct-Mapped Cache Architecture
- 32-bit CPU Address Interface
- 16 Cache Lines
- 128-bit Cache Line (4 × 32-bit words)
- Tag and Valid Bit Storage
- Cache Hit/Miss Detection
- FSM Controlled Cache Operation
- Main Memory Interface
- Asynchronous Active-Low Reset
- Functional Testbench

---

## Cache Organization

| Parameter | Value |
|-----------|-------|
| Cache Type | Direct Mapped |
| Address Width | 32 bits |
| Number of Cache Lines | 16 |
| Cache Line Size | 128 bits |
| Word Size | 32 bits |
| Words per Line | 4 |
| Tag Bits | 26 |
| Index Bits | 4 |
| Offset Bits | 2 |

---

## Project Structure

```
.
├── cache_top.v
├── addr_decoder.v
├── compare.v
├── valid.v
├── tag.v
├── data_cache.v
├── word_mux.v
├── main_memory.v
├── fsm_cache.v
├── cache_tb.v
└── README.md
```

---

## Module Description

### cache_top
Top-level module that connects all cache components.

### addr_decoder
Decodes the CPU address into:
- Tag
- Index
- Offset

### compare
Compares the CPU tag with the stored cache tag and generates the **hit** signal.

### valid
Stores and updates the valid bit for each cache line.

### tag
Stores the tag corresponding to each cache line.

### data_cache
Stores 128-bit cache lines.

### word_mux
Selects one of the four 32-bit words from a cache line using the offset bits.

### main_memory
Simulates the main memory. On a cache miss, it returns a complete 128-bit cache line.

### fsm_cache
Controls the cache operation using a Finite State Machine.

States include:
- IDLE
- COMPARE
- HIT
- MISS
- MEM_WAIT
- UPDATE
- DONE

---

## Address Format

```
 31                           6 5        2 1      0
+------------------------------+----------+--------+
|          Tag (26)            | Index(4) |Offset(2)|
+------------------------------+----------+--------+
```

---

## Cache Operation

### Cache Hit

1. CPU issues a request.
2. Address is decoded.
3. Valid bit is checked.
4. Tags are compared.
5. Requested word is read directly from the cache.
6. `cpu_ready` is asserted.

---

### Cache Miss

1. CPU issues a request.
2. Tag comparison fails.
3. FSM asserts `mem_read`.
4. Main memory returns a 128-bit cache line.
5. Cache line, tag, and valid bit are updated.
6. Requested word is selected.
7. `cpu_ready` is asserted.

---

## Simulation

The project has been verified using a Verilog testbench covering:

- Reset functionality
- Cache Miss
- Cache Update
- Cache Hit
- Main Memory Read
- Data Output Verification
- FSM Operation

---

## Important Signals

| Signal | Description |
|---------|-------------|
| `cpu_req` | CPU request signal |
| `cpu_addr` | CPU address |
| `cpu_ready` | Indicates completion of request |
| `mem_read` | Main memory read request |
| `mem_ready` | Main memory response |
| `hit` | Cache hit indicator |
| `valid` | Valid bit |
| `data_o` | Data returned to CPU |

---

## Tools Used

- Verilog HDL
- Xilinx Vivado
- Vivado Simulator
