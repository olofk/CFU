// cfu_li.svh: CFU-LI package
//
// Copyright (C) 2019-2022, Gray Research LLC.
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//    http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

`ifndef CFU_SVH
`define CFU_SVH

`include "common.svh"

`define CFU_L0_PARAMS(n_cfus,func_id_w,data_w)              \
    parameter int CFU_LI_VERSION    = 'h01_00_00,           \
    parameter int CFU_N_CFUS        = n_cfus,               \
    parameter int CFU_CFU_ID_W      = $clog2(CFU_N_CFUS),   \
    parameter int CFU_FUNC_ID_W     = func_id_w,            \
    parameter int CFU_DATA_W        = data_w

`define CFU_L1_PARAMS(n_cfus,n_states,latency,reset_latency,func_id_w,data_w) \
    parameter int CFU_LI_VERSION    = 'h01_00_00,           \
    parameter int CFU_N_CFUS        = n_cfus,               \
    parameter int CFU_N_STATES      = n_states,             \
    parameter int CFU_LATENCY       = latency,              \
    parameter int CFU_RESET_LATENCY = reset_latency,        \
    parameter int CFU_CFU_ID_W      = $clog2(CFU_N_CFUS),   \
    parameter int CFU_STATE_ID_W    = $clog2(CFU_N_STATES), \
    parameter int CFU_FUNC_ID_W     = func_id_w,            \
    parameter int CFU_DATA_W        = data_w

`define CFU_L2_PARAMS(n_cfus,n_states,func_id_w,insn_w,data_w) \
    parameter int CFU_LI_VERSION    = 'h01_00_00,           \
    parameter int CFU_N_CFUS        = n_cfus,               \
    parameter int CFU_N_STATES      = n_states,             \
    parameter int CFU_CFU_ID_W      = $clog2(CFU_N_CFUS),   \
    parameter int CFU_STATE_ID_W    = $clog2(CFU_N_STATES), \
    parameter int CFU_FUNC_ID_W     = func_id_w,            \
    parameter int CFU_INSN_W        = insn_w,               \
    parameter int CFU_DATA_W        = data_w

`define CFU_L2_PARAMS_MAP               \
    .CFU_LI_VERSION(CFU_LI_VERSION),    \
    .CFU_N_CFUS(CFU_N_CFUS),            \
    .CFU_N_STATES(CFU_N_STATES),        \
    .CFU_CFU_ID_W(CFU_CFU_ID_W),        \
    .CFU_STATE_ID_W(CFU_STATE_ID_W),    \
    .CFU_FUNC_ID_W(CFU_FUNC_ID_W),      \
    .CFU_INSN_W(CFU_INSN_W),            \
    .CFU_DATA_W(CFU_DATA_W)

`define CFU_L3_PARAMS(n_cfus,n_states,req_id_w,func_id_w,insn_w,data_w) \
    parameter int CFU_LI_VERSION    = 'h01_00_00,           \
    parameter int CFU_N_CFUS        = n_cfus,               \
    parameter int CFU_N_STATES      = n_states,             \
    parameter int CFU_REQ_ID_W      = req_id_w,             \
    parameter int CFU_CFU_ID_W      = $clog2(CFU_N_CFUS),   \
    parameter int CFU_STATE_ID_W    = $clog2(CFU_N_STATES), \
    parameter int CFU_FUNC_ID_W     = func_id_w,            \
    parameter int CFU_INSN_W        = insn_w,               \
    parameter int CFU_DATA_W        = data_w

`define CFU_L0_PORTS(input,output,req,resp)     \
    input  logic                req``_valid,    \
    input  `V(CFU_CFU_ID_W)     req``_cfu,      \
    input  `V(CFU_FUNC_ID_W)    req``_func,     \
    input  `V(CFU_DATA_W)       req``_data0,    \
    input  `V(CFU_DATA_W)       req``_data1,    \
    output cfu_status_t         resp``_status,  \
    output `V(CFU_DATA_W)       resp``_data

`define CFU_CLOCK_PORTS                         \
    input  logic                clk,            \
    input  logic                rst,            \
    input  logic                clk_en

`define CFU_L1_PORTS(input,output,req,resp)     \
    input  logic                req``_valid,    \
    input  `V(CFU_CFU_ID_W)     req``_cfu,      \
    input  `V(CFU_STATE_ID_W)   req``_state,    \
    input  `V(CFU_FUNC_ID_W)    req``_func,     \
    input  `V(CFU_DATA_W)       req``_data0,    \
    input  `V(CFU_DATA_W)       req``_data1,    \
    output logic                resp``_valid,   \
    output cfu_status_t         resp``_status,  \
    output `V(CFU_DATA_W)       resp``_data

`define CFU_L2_PORTS(input,output,req,resp)     \
    input  logic                req``_valid,    \
    output logic                req``_ready,    \
    input  `V(CFU_CFU_ID_W)     req``_cfu,      \
    input  `V(CFU_STATE_ID_W)   req``_state,    \
    input  `V(CFU_FUNC_ID_W)    req``_func,     \
    input  `V(CFU_INSN_W)       req``_insn,     \
    input  `V(CFU_DATA_W)       req``_data0,    \
    input  `V(CFU_DATA_W)       req``_data1,    \
    output logic                resp``_valid,   \
    input  logic                resp``_ready,   \
    output cfu_status_t         resp``_status,  \
    output `V(CFU_DATA_W)       resp``_data

`define CFU_L3_PORTS(input,output,req,resp)     \
    input  logic                req``_valid,    \
    output logic                req``_ready,    \
    input  `V(CFU_REQ_ID_W)     req``_id,       \
    input  `V(CFU_CFU_ID_W)     req``_cfu,      \
    input  `V(CFU_STATE_ID_W)   req``_state,    \
    input  `V(CFU_FUNC_ID_W)    req``_func,     \
    input  `V(CFU_INSN_W)       req``_insn,     \
    input  `V(CFU_DATA_W)       req``_data0,    \
    input  `V(CFU_DATA_W)       req``_data1,    \
    output logic                resp``_valid,   \
    input  logic                resp``_ready,   \
    output `V(CFU_REQ_ID_W)     resp``_id,      \
    output cfu_status_t         resp``_status,  \
    output `V(CFU_DATA_W)       resp``_data

`define CFU_L1_ALL_PORTS(input,output,req,resp) \
    `CFU_CLOCK_PORTS,                           \
    `CFU_L1_PORTS(input,output,req,resp)

`define CFU_L2_ALL_PORTS(input,output,req,resp) \
    `CFU_CLOCK_PORTS,                           \
    `CFU_L2_PORTS(input,output,req,resp)

`define CFU_L3_ALL_PORTS(input,output,req,resp) \
    `CFU_CLOCK_PORTS,                           \
    `CFU_L3_PORTS(input,output,req,resp)

package cfu_pkg;

import common_pkg::*;

function bit check_cfu_l0_params(string name, int version, int n_cfus, int cfu_w, int func_w, int data_w);
    return check_param(name, "CFU_LI_VERSION", version, 'h01_00_00)
        && check_param_pos(name, "CFU_N_CFUS", n_cfus)
        && check_param_range(name, "CFU_CFU_ID_W", cfu_w, 0, 16)
        && check_param_range(name, "CFU_FUNC_ID_W", func_w, 0, 10)
        && check_param_2(name, "CFU_DATA_ID_W", data_w, 32, 64);
endfunction

function bit check_cfu_l1_params(
    string name, int version, int n_cfus, int latency, int reset_latency, int cfu_w,
    int state_w, int func_w, int data_w
);
    return check_param(name, "CFU_LI_VERSION", version, 'h01_00_00)
        && check_param_pos(name, "CFU_N_CFUS", n_cfus)
        // check_param CFU_N_STATES in each CFU
        && check_param_nonneg(name, "CFU_LATENCY", latency)
        && check_param_nonneg(name, "CFU_RESET_LATENCY", reset_latency)
        && check_param_range(name, "CFU_CFU_ID_W", cfu_w, 0, 16)
        && check_param_range(name, "CFU_STATE_ID_W", state_w, 0, 16)
        && check_param_range(name, "CFU_FUNC_ID_W", func_w, 0, 10)
        && check_param_2(name, "CFU_DATA_ID_W", data_w, 32, 64);
endfunction

function bit check_cfu_l2_params(string name, int version, int n_cfus, int cfu_w, int state_w, int func_w, int insn_w, int data_w);
    return check_param(name, "CFU_LI_VERSION", version, 'h01_00_00)
        && check_param_pos(name, "CFU_N_CFUS", n_cfus)
        // check_param CFU_N_STATES in each CFU
        && check_param_range(name, "CFU_CFU_ID_W", cfu_w, 0, 16)
        && check_param_range(name, "CFU_STATE_ID_W", state_w, 0, 16)
        && check_param_range(name, "CFU_FUNC_ID_W", func_w, 0, 10)
        && check_param_2(name, "CFU_INSN_W", insn_w, 0, 32)
        && check_param_2(name, "CFU_DATA_ID_W", data_w, 32, 64);
endfunction

function bit check_cfu_l3_params(string name, int version, int n_cfus, int cfu_w, int state_w, int func_w, int insn_w, int data_w);
    return check_cfu_l2_params(name, version, n_cfus, cfu_w, state_w, func_w, insn_w, data_w);
endfunction

parameter int CFU_STATUS_W  = 3;

typedef enum logic [CFU_STATUS_W-1:0] {
    CFU_OK,                         // OK: no errors
    CFU_ERROR_CFU,                  // error: invalid CFU_ID
    CFU_ERROR_OFF,                  // error: (stateful interface) is off
    CFU_ERROR_STATE,                // error: invalid STATE_ID
    CFU_ERROR_FUNC,                 // error: invalid CF_ID
    CFU_ERROR_OP,                   // error: invalid operation or operands
    CFU_ERROR_CUSTOM                // error: (stateful interface) custom error
} cfu_status_t;                     // CFU response status

typedef enum logic [1:0] {
    CFU_OFF,                        // context off: any use is an error
    CFU_INIT,                       // context on, reset to zero
    CFU_CLEAN,                      // context hasn't changed since last context save
    CFU_DIRTY                       // context has changed
} cfu_cs_e;                         // stateful CFU "CS" context status

typedef logic [1:0] cfu_cs_t;       // mitigate iverilog shortcoming, can't cast to enum (?)

typedef struct packed {
    `V(8)       error;              // custom error status
    `V(12)      reserved;           // reserved, writes ignored, reads as zero
    `V(10)      state_size;         // state context size in words
    cfu_cs_t    cs;                 // context "CS" status
} cfu_csw_t;                        // stateful CFU interface state context status word

typedef enum logic [9:0] {
    cfid_read_status    = 1023,     // read interface state context status word
    cfid_write_status   = 1022,     // write interface state context status word
    cfid_read_state     = 1021,     // read one word of current state context
    cfid_write_state    = 1020      // write one word of current state context
} cfid_t;                           // stateful CFU standard custom function IDs

endpackage : cfu_pkg
`endif
