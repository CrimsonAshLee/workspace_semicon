// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
// Date        : Thu Sep  4 14:57:53 2025
// Host        : user8-B70TV-AN5TB8W running 64-bit Ubuntu 24.04.3 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/user8/workspace_semicon/verilog/basys3_exam/basys3_exam.gen/sources_1/bd/soc_dht11/ip/soc_dht11_myip_dht11_0_0/soc_dht11_myip_dht11_0_0_sim_netlist.v
// Design      : soc_dht11_myip_dht11_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "soc_dht11_myip_dht11_0_0,myip_dht11,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "myip_dht11,Vivado 2024.2" *) 
(* NotValidForBitStream *)
module soc_dht11_myip_dht11_0_0
   (dht11_data,
    led,
    s00_axi_aclk,
    s00_axi_aresetn,
    s00_axi_awaddr,
    s00_axi_awprot,
    s00_axi_awvalid,
    s00_axi_awready,
    s00_axi_wdata,
    s00_axi_wstrb,
    s00_axi_wvalid,
    s00_axi_wready,
    s00_axi_bresp,
    s00_axi_bvalid,
    s00_axi_bready,
    s00_axi_araddr,
    s00_axi_arprot,
    s00_axi_arvalid,
    s00_axi_arready,
    s00_axi_rdata,
    s00_axi_rresp,
    s00_axi_rvalid,
    s00_axi_rready);
  inout dht11_data;
  output [15:0]led;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S00_AXI_CLK CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXI_CLK, ASSOCIATED_BUSIF S00_AXI, ASSOCIATED_RESET s00_axi_aresetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_clk_out1, INSERT_VIP 0" *) input s00_axi_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S00_AXI_RST RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXI_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s00_axi_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWADDR" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXI, WIZ_DATA_WIDTH 32, WIZ_NUM_REG 8, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 5, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /clk_wiz_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [4:0]s00_axi_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWPROT" *) input [2:0]s00_axi_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWVALID" *) input s00_axi_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWREADY" *) output s00_axi_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WDATA" *) input [31:0]s00_axi_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WSTRB" *) input [3:0]s00_axi_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WVALID" *) input s00_axi_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WREADY" *) output s00_axi_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BRESP" *) output [1:0]s00_axi_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BVALID" *) output s00_axi_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BREADY" *) input s00_axi_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARADDR" *) input [4:0]s00_axi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARPROT" *) input [2:0]s00_axi_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARVALID" *) input s00_axi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARREADY" *) output s00_axi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RDATA" *) output [31:0]s00_axi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RRESP" *) output [1:0]s00_axi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RVALID" *) output s00_axi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RREADY" *) input s00_axi_rready;

  wire \<const0> ;
  wire dht11_data;
  wire [11:0]\^led ;
  wire s00_axi_aclk;
  wire [4:0]s00_axi_araddr;
  wire s00_axi_aresetn;
  wire s00_axi_arready;
  wire s00_axi_arvalid;
  wire [4:0]s00_axi_awaddr;
  wire s00_axi_awready;
  wire s00_axi_awvalid;
  wire s00_axi_bready;
  wire s00_axi_bvalid;
  wire [31:0]s00_axi_rdata;
  wire s00_axi_rready;
  wire s00_axi_rvalid;
  wire [31:0]s00_axi_wdata;
  wire s00_axi_wready;
  wire [3:0]s00_axi_wstrb;
  wire s00_axi_wvalid;

  assign led[15] = \<const0> ;
  assign led[14] = \<const0> ;
  assign led[13] = \<const0> ;
  assign led[12] = \<const0> ;
  assign led[11:0] = \^led [11:0];
  assign s00_axi_bresp[1] = \<const0> ;
  assign s00_axi_bresp[0] = \<const0> ;
  assign s00_axi_rresp[1] = \<const0> ;
  assign s00_axi_rresp[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  soc_dht11_myip_dht11_0_0_myip_dht11 inst
       (.Q(\^led [11:6]),
        .axi_arready_reg(s00_axi_arready),
        .axi_awready_reg(s00_axi_awready),
        .axi_rvalid_reg(s00_axi_rvalid),
        .dht11_data(dht11_data),
        .led(\^led [5:0]),
        .s00_axi_aclk(s00_axi_aclk),
        .s00_axi_araddr(s00_axi_araddr[4:2]),
        .s00_axi_aresetn(s00_axi_aresetn),
        .s00_axi_arvalid(s00_axi_arvalid),
        .s00_axi_awaddr(s00_axi_awaddr[4:2]),
        .s00_axi_awvalid(s00_axi_awvalid),
        .s00_axi_bready(s00_axi_bready),
        .s00_axi_bvalid(s00_axi_bvalid),
        .s00_axi_rdata(s00_axi_rdata),
        .s00_axi_rready(s00_axi_rready),
        .s00_axi_wdata(s00_axi_wdata),
        .s00_axi_wready(s00_axi_wready),
        .s00_axi_wstrb(s00_axi_wstrb),
        .s00_axi_wvalid(s00_axi_wvalid));
endmodule

(* ORIG_REF_NAME = "clock_div_100" *) 
module soc_dht11_myip_dht11_0_0_clock_div_100
   (clk_div_100,
    s00_axi_aresetn_0,
    ff_old_reg,
    \cnt_sysclk_reg[5]_0 ,
    O,
    \count_usec_reg[7] ,
    \count_usec_reg[11] ,
    \count_usec_reg[15] ,
    \count_usec_reg[19] ,
    \count_usec_reg[21] ,
    s00_axi_aclk,
    clk_div_100_reg_0,
    count_usec_reg_0_sp_1,
    count_usec_reg,
    s00_axi_aresetn);
  output clk_div_100;
  output s00_axi_aresetn_0;
  output ff_old_reg;
  output \cnt_sysclk_reg[5]_0 ;
  output [3:0]O;
  output [3:0]\count_usec_reg[7] ;
  output [3:0]\count_usec_reg[11] ;
  output [3:0]\count_usec_reg[15] ;
  output [3:0]\count_usec_reg[19] ;
  output [1:0]\count_usec_reg[21] ;
  input s00_axi_aclk;
  input clk_div_100_reg_0;
  input count_usec_reg_0_sp_1;
  input [21:0]count_usec_reg;
  input s00_axi_aresetn;

  wire [3:0]O;
  wire clk_div_100;
  wire clk_div_100_reg_0;
  wire [5:0]cnt_sysclk_reg;
  wire \cnt_sysclk_reg[5]_0 ;
  wire [21:0]count_usec_reg;
  wire [3:0]\count_usec_reg[11] ;
  wire [3:0]\count_usec_reg[15] ;
  wire [3:0]\count_usec_reg[19] ;
  wire [1:0]\count_usec_reg[21] ;
  wire [3:0]\count_usec_reg[7] ;
  wire count_usec_reg_0_sn_1;
  wire ff_old_reg;
  wire [5:0]p_0_in;
  wire s00_axi_aclk;
  wire s00_axi_aresetn;
  wire s00_axi_aresetn_0;

  assign count_usec_reg_0_sn_1 = count_usec_reg_0_sp_1;
  soc_dht11_myip_dht11_0_0_edge_detector_p_0 cl_ed
       (.O(O),
        .clk_div_100(clk_div_100),
        .count_usec_reg(count_usec_reg),
        .\count_usec_reg[11] (\count_usec_reg[11] ),
        .\count_usec_reg[15] (\count_usec_reg[15] ),
        .\count_usec_reg[19] (\count_usec_reg[19] ),
        .\count_usec_reg[21] (\count_usec_reg[21] ),
        .\count_usec_reg[7] (\count_usec_reg[7] ),
        .count_usec_reg_0_sp_1(count_usec_reg_0_sn_1),
        .ff_old_reg_0(ff_old_reg),
        .s00_axi_aclk(s00_axi_aclk),
        .s00_axi_aresetn(s00_axi_aresetn),
        .s00_axi_aresetn_0(s00_axi_aresetn_0));
  LUT6 #(
    .INIT(64'h8888888888888880)) 
    clk_div_100_i_2
       (.I0(cnt_sysclk_reg[5]),
        .I1(cnt_sysclk_reg[4]),
        .I2(cnt_sysclk_reg[1]),
        .I3(cnt_sysclk_reg[0]),
        .I4(cnt_sysclk_reg[3]),
        .I5(cnt_sysclk_reg[2]),
        .O(\cnt_sysclk_reg[5]_0 ));
  FDCE clk_div_100_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .CLR(s00_axi_aresetn_0),
        .D(clk_div_100_reg_0),
        .Q(clk_div_100));
  LUT6 #(
    .INIT(64'h00010F0F0F0F0F0F)) 
    \cnt_sysclk[0]_i_1 
       (.I0(cnt_sysclk_reg[2]),
        .I1(cnt_sysclk_reg[3]),
        .I2(cnt_sysclk_reg[0]),
        .I3(cnt_sysclk_reg[1]),
        .I4(cnt_sysclk_reg[4]),
        .I5(cnt_sysclk_reg[5]),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h0666)) 
    \cnt_sysclk[1]_i_1 
       (.I0(cnt_sysclk_reg[0]),
        .I1(cnt_sysclk_reg[1]),
        .I2(cnt_sysclk_reg[4]),
        .I3(cnt_sysclk_reg[5]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h006A6A6A)) 
    \cnt_sysclk[2]_i_1 
       (.I0(cnt_sysclk_reg[2]),
        .I1(cnt_sysclk_reg[0]),
        .I2(cnt_sysclk_reg[1]),
        .I3(cnt_sysclk_reg[4]),
        .I4(cnt_sysclk_reg[5]),
        .O(p_0_in[2]));
  LUT6 #(
    .INIT(64'h00006CCC6CCC6CCC)) 
    \cnt_sysclk[3]_i_1 
       (.I0(cnt_sysclk_reg[2]),
        .I1(cnt_sysclk_reg[3]),
        .I2(cnt_sysclk_reg[0]),
        .I3(cnt_sysclk_reg[1]),
        .I4(cnt_sysclk_reg[4]),
        .I5(cnt_sysclk_reg[5]),
        .O(p_0_in[3]));
  LUT6 #(
    .INIT(64'h000180007FFF8000)) 
    \cnt_sysclk[4]_i_1 
       (.I0(cnt_sysclk_reg[2]),
        .I1(cnt_sysclk_reg[3]),
        .I2(cnt_sysclk_reg[0]),
        .I3(cnt_sysclk_reg[1]),
        .I4(cnt_sysclk_reg[4]),
        .I5(cnt_sysclk_reg[5]),
        .O(p_0_in[4]));
  LUT6 #(
    .INIT(64'h40000002AAAAAAAA)) 
    \cnt_sysclk[5]_i_1 
       (.I0(cnt_sysclk_reg[5]),
        .I1(cnt_sysclk_reg[2]),
        .I2(cnt_sysclk_reg[1]),
        .I3(cnt_sysclk_reg[0]),
        .I4(cnt_sysclk_reg[3]),
        .I5(cnt_sysclk_reg[4]),
        .O(p_0_in[5]));
  FDCE \cnt_sysclk_reg[0] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .CLR(s00_axi_aresetn_0),
        .D(p_0_in[0]),
        .Q(cnt_sysclk_reg[0]));
  FDCE \cnt_sysclk_reg[1] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .CLR(s00_axi_aresetn_0),
        .D(p_0_in[1]),
        .Q(cnt_sysclk_reg[1]));
  FDCE \cnt_sysclk_reg[2] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .CLR(s00_axi_aresetn_0),
        .D(p_0_in[2]),
        .Q(cnt_sysclk_reg[2]));
  FDCE \cnt_sysclk_reg[3] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .CLR(s00_axi_aresetn_0),
        .D(p_0_in[3]),
        .Q(cnt_sysclk_reg[3]));
  FDCE \cnt_sysclk_reg[4] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .CLR(s00_axi_aresetn_0),
        .D(p_0_in[4]),
        .Q(cnt_sysclk_reg[4]));
  FDCE \cnt_sysclk_reg[5] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .CLR(s00_axi_aresetn_0),
        .D(p_0_in[5]),
        .Q(cnt_sysclk_reg[5]));
endmodule

(* ORIG_REF_NAME = "dht11_cntr" *) 
module soc_dht11_myip_dht11_0_0_dht11_cntr
   (clk_div_100,
    SR,
    count_usec_e_reg_0,
    dht11_data_out_e_reg_0,
    Q,
    \state_reg[5]_0 ,
    \state_reg[1]_0 ,
    \state_reg[5]_1 ,
    \count_usec_reg[14]_0 ,
    \state_reg[3]_0 ,
    \state_reg[0]_0 ,
    \state_reg[0]_1 ,
    dht11_data_out_e,
    \cnt_sysclk_reg[5] ,
    \humidity_reg[7]_0 ,
    \temperature_reg[7]_0 ,
    dht11_data,
    s00_axi_aclk,
    clk_div_100_reg,
    count_usec_e_reg_1,
    dht11_data_out_e_reg_1,
    s00_axi_aresetn);
  output clk_div_100;
  output [0:0]SR;
  output count_usec_e_reg_0;
  output dht11_data_out_e_reg_0;
  output [5:0]Q;
  output [5:0]\state_reg[5]_0 ;
  output \state_reg[1]_0 ;
  output \state_reg[5]_1 ;
  output \count_usec_reg[14]_0 ;
  output \state_reg[3]_0 ;
  output \state_reg[0]_0 ;
  output \state_reg[0]_1 ;
  output dht11_data_out_e;
  output \cnt_sysclk_reg[5] ;
  output [7:0]\humidity_reg[7]_0 ;
  output [7:0]\temperature_reg[7]_0 ;
  inout dht11_data;
  input s00_axi_aclk;
  input clk_div_100_reg;
  input count_usec_e_reg_1;
  input dht11_data_out_e_reg_1;
  input s00_axi_aresetn;

  wire [5:0]Q;
  wire [0:0]SR;
  wire clk_div_100;
  wire clk_div_100_reg;
  wire \cnt_sysclk_reg[5] ;
  wire count_usec_e_i_5_n_0;
  wire count_usec_e_reg_0;
  wire count_usec_e_reg_1;
  wire [21:0]count_usec_reg;
  wire \count_usec_reg[14]_0 ;
  wire data_count;
  wire \data_count[4]_i_4_n_0 ;
  wire \data_count[5]_i_6_n_0 ;
  wire \data_count[5]_i_7_n_0 ;
  wire dht11_data;
  wire dht11_data_out_e;
  wire dht11_data_out_e_i_10_n_0;
  wire dht11_data_out_e_i_11_n_0;
  wire dht11_data_out_e_i_5_n_0;
  wire dht11_data_out_e_i_6_n_0;
  wire dht11_data_out_e_i_7_n_0;
  wire dht11_data_out_e_i_8_n_0;
  wire dht11_data_out_e_i_9_n_0;
  wire dht11_data_out_e_reg_0;
  wire dht11_data_out_e_reg_1;
  wire dht_ed_n_0;
  wire dht_ed_n_1;
  wire dht_ed_n_10;
  wire dht_ed_n_11;
  wire dht_ed_n_12;
  wire dht_ed_n_13;
  wire dht_ed_n_14;
  wire dht_ed_n_15;
  wire dht_ed_n_16;
  wire dht_ed_n_17;
  wire dht_ed_n_18;
  wire dht_ed_n_19;
  wire dht_ed_n_2;
  wire dht_ed_n_27;
  wire dht_ed_n_3;
  wire dht_ed_n_4;
  wire dht_ed_n_5;
  wire dht_ed_n_52;
  wire dht_ed_n_53;
  wire dht_ed_n_54;
  wire dht_ed_n_55;
  wire dht_ed_n_56;
  wire dht_ed_n_57;
  wire dht_ed_n_58;
  wire dht_ed_n_59;
  wire dht_ed_n_6;
  wire dht_ed_n_60;
  wire dht_ed_n_61;
  wire dht_ed_n_62;
  wire dht_ed_n_63;
  wire dht_ed_n_64;
  wire dht_ed_n_65;
  wire dht_ed_n_66;
  wire dht_ed_n_67;
  wire dht_ed_n_68;
  wire dht_ed_n_69;
  wire dht_ed_n_7;
  wire dht_ed_n_70;
  wire dht_ed_n_8;
  wire dht_ed_n_9;
  wire [7:0]humidity1;
  wire humidity1__2_carry__0_n_1;
  wire humidity1__2_carry__0_n_2;
  wire humidity1__2_carry__0_n_3;
  wire humidity1__2_carry_n_0;
  wire humidity1__2_carry_n_1;
  wire humidity1__2_carry_n_2;
  wire humidity1__2_carry_n_3;
  wire [7:0]\humidity_reg[7]_0 ;
  wire [5:0]next_state;
  wire \next_state[5]_i_11_n_0 ;
  wire \next_state[5]_i_12_n_0 ;
  wire \next_state[5]_i_13_n_0 ;
  wire \next_state[5]_i_14_n_0 ;
  wire \next_state[5]_i_5_n_0 ;
  wire \next_state[5]_i_8_n_0 ;
  wire [7:0]p_0_in1_in;
  wire p_0_in_0;
  wire [7:0]p_0_in__0;
  wire [5:0]p_1_in;
  wire [7:0]p_1_in__0;
  wire [1:0]read_state;
  wire \read_state[1]_i_2_n_0 ;
  wire \read_state[1]_i_3_n_0 ;
  wire \read_state[1]_i_4_n_0 ;
  wire \read_state[1]_i_5_n_0 ;
  wire \read_state[1]_i_6_n_0 ;
  wire \read_state[1]_i_7_n_0 ;
  wire \read_state[1]_i_8_n_0 ;
  wire s00_axi_aclk;
  wire s00_axi_aresetn;
  wire \state_reg[0]_0 ;
  wire \state_reg[0]_1 ;
  wire \state_reg[1]_0 ;
  wire \state_reg[3]_0 ;
  wire [5:0]\state_reg[5]_0 ;
  wire \state_reg[5]_1 ;
  wire [39:0]temp_data;
  wire \temp_data[0]_i_2_n_0 ;
  wire \temp_data[0]_i_3_n_0 ;
  wire \temp_data[0]_i_4_n_0 ;
  wire [7:0]\temperature_reg[7]_0 ;
  wire us_clk_n_10;
  wire us_clk_n_11;
  wire us_clk_n_12;
  wire us_clk_n_13;
  wire us_clk_n_14;
  wire us_clk_n_15;
  wire us_clk_n_16;
  wire us_clk_n_17;
  wire us_clk_n_18;
  wire us_clk_n_19;
  wire us_clk_n_2;
  wire us_clk_n_20;
  wire us_clk_n_21;
  wire us_clk_n_22;
  wire us_clk_n_23;
  wire us_clk_n_24;
  wire us_clk_n_25;
  wire us_clk_n_4;
  wire us_clk_n_5;
  wire us_clk_n_6;
  wire us_clk_n_7;
  wire us_clk_n_8;
  wire us_clk_n_9;
  wire [3:3]NLW_humidity1__2_carry__0_CO_UNCONNECTED;

  LUT6 #(
    .INIT(64'hFFFFFFFF4444F444)) 
    count_usec_e_i_3
       (.I0(count_usec_e_i_5_n_0),
        .I1(\state_reg[5]_0 [0]),
        .I2(\state_reg[5]_0 [5]),
        .I3(read_state[1]),
        .I4(\read_state[1]_i_2_n_0 ),
        .I5(dht11_data_out_e),
        .O(\state_reg[0]_1 ));
  LUT5 #(
    .INIT(32'hA8888888)) 
    count_usec_e_i_5
       (.I0(count_usec_reg[21]),
        .I1(count_usec_reg[20]),
        .I2(count_usec_reg[19]),
        .I3(count_usec_reg[18]),
        .I4(dht11_data_out_e_i_6_n_0),
        .O(count_usec_e_i_5_n_0));
  FDRE count_usec_e_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(count_usec_e_reg_1),
        .Q(count_usec_e_reg_0),
        .R(1'b0));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[0] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_7),
        .Q(count_usec_reg[0]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[10] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_13),
        .Q(count_usec_reg[10]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[11] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_12),
        .Q(count_usec_reg[11]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[12] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_19),
        .Q(count_usec_reg[12]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[13] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_18),
        .Q(count_usec_reg[13]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[14] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_17),
        .Q(count_usec_reg[14]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[15] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_16),
        .Q(count_usec_reg[15]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[16] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_23),
        .Q(count_usec_reg[16]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[17] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_22),
        .Q(count_usec_reg[17]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[18] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_21),
        .Q(count_usec_reg[18]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[19] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_20),
        .Q(count_usec_reg[19]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[1] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_6),
        .Q(count_usec_reg[1]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[20] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_25),
        .Q(count_usec_reg[20]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[21] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_24),
        .Q(count_usec_reg[21]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[2] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_5),
        .Q(count_usec_reg[2]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[3] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_4),
        .Q(count_usec_reg[3]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[4] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_11),
        .Q(count_usec_reg[4]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[5] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_10),
        .Q(count_usec_reg[5]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[6] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_9),
        .Q(count_usec_reg[6]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[7] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_8),
        .Q(count_usec_reg[7]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[8] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_15),
        .Q(count_usec_reg[8]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \count_usec_reg[9] 
       (.C(s00_axi_aclk),
        .CE(us_clk_n_2),
        .CLR(SR),
        .D(us_clk_n_14),
        .Q(count_usec_reg[9]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \data_count[4]_i_4 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(Q[2]),
        .O(\data_count[4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000100)) 
    \data_count[5]_i_1 
       (.I0(\state_reg[5]_0 [2]),
        .I1(\state_reg[5]_0 [4]),
        .I2(\state_reg[5]_0 [3]),
        .I3(\state_reg[5]_0 [5]),
        .I4(\state_reg[5]_0 [1]),
        .I5(\state_reg[5]_0 [0]),
        .O(data_count));
  LUT2 #(
    .INIT(4'h2)) 
    \data_count[5]_i_6 
       (.I0(read_state[1]),
        .I1(read_state[0]),
        .O(\data_count[5]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \data_count[5]_i_7 
       (.I0(Q[3]),
        .I1(Q[2]),
        .I2(Q[0]),
        .I3(Q[1]),
        .O(\data_count[5]_i_7_n_0 ));
  FDCE \data_count_reg[0] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_17),
        .Q(Q[0]));
  FDCE \data_count_reg[1] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_16),
        .Q(Q[1]));
  FDCE \data_count_reg[2] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_15),
        .Q(Q[2]));
  FDCE \data_count_reg[3] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_14),
        .Q(Q[3]));
  FDCE \data_count_reg[4] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_13),
        .Q(Q[4]));
  FDCE \data_count_reg[5] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_12),
        .Q(Q[5]));
  LUT5 #(
    .INIT(32'hE0000000)) 
    dht11_data_out_e_i_10
       (.I0(count_usec_reg[4]),
        .I1(count_usec_reg[5]),
        .I2(count_usec_reg[6]),
        .I3(count_usec_reg[10]),
        .I4(count_usec_reg[9]),
        .O(dht11_data_out_e_i_10_n_0));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'hC080C000)) 
    dht11_data_out_e_i_11
       (.I0(count_usec_reg[7]),
        .I1(count_usec_reg[9]),
        .I2(count_usec_reg[10]),
        .I3(count_usec_reg[8]),
        .I4(count_usec_reg[6]),
        .O(dht11_data_out_e_i_11_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    dht11_data_out_e_i_2
       (.I0(\state_reg[5]_0 [1]),
        .I1(dht11_data_out_e_i_5_n_0),
        .O(dht11_data_out_e));
  LUT6 #(
    .INIT(64'h0000000100010000)) 
    dht11_data_out_e_i_3
       (.I0(\state_reg[5]_0 [5]),
        .I1(\state_reg[5]_0 [3]),
        .I2(\state_reg[5]_0 [4]),
        .I3(\state_reg[5]_0 [2]),
        .I4(\state_reg[5]_0 [0]),
        .I5(\state_reg[5]_0 [1]),
        .O(\state_reg[5]_1 ));
  LUT6 #(
    .INIT(64'hAAAA800000000000)) 
    dht11_data_out_e_i_4
       (.I0(\state_reg[5]_0 [0]),
        .I1(dht11_data_out_e_i_6_n_0),
        .I2(count_usec_reg[18]),
        .I3(count_usec_reg[19]),
        .I4(count_usec_reg[20]),
        .I5(count_usec_reg[21]),
        .O(\state_reg[0]_0 ));
  LUT6 #(
    .INIT(64'h0000040044444444)) 
    dht11_data_out_e_i_5
       (.I0(\read_state[1]_i_3_n_0 ),
        .I1(dht11_data_out_e_i_7_n_0),
        .I2(dht11_data_out_e_i_8_n_0),
        .I3(dht11_data_out_e_i_9_n_0),
        .I4(dht11_data_out_e_i_10_n_0),
        .I5(count_usec_reg[14]),
        .O(dht11_data_out_e_i_5_n_0));
  LUT6 #(
    .INIT(64'hFBAAAAAAAAAAAAAA)) 
    dht11_data_out_e_i_6
       (.I0(count_usec_reg[17]),
        .I1(dht11_data_out_e_i_9_n_0),
        .I2(dht11_data_out_e_i_11_n_0),
        .I3(count_usec_reg[14]),
        .I4(count_usec_reg[16]),
        .I5(count_usec_reg[15]),
        .O(dht11_data_out_e_i_6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'h1)) 
    dht11_data_out_e_i_7
       (.I0(count_usec_reg[15]),
        .I1(count_usec_reg[16]),
        .O(dht11_data_out_e_i_7_n_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h8880)) 
    dht11_data_out_e_i_8
       (.I0(count_usec_reg[10]),
        .I1(count_usec_reg[9]),
        .I2(count_usec_reg[8]),
        .I3(count_usec_reg[7]),
        .O(dht11_data_out_e_i_8_n_0));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h01)) 
    dht11_data_out_e_i_9
       (.I0(count_usec_reg[12]),
        .I1(count_usec_reg[11]),
        .I2(count_usec_reg[13]),
        .O(dht11_data_out_e_i_9_n_0));
  FDCE dht11_data_out_e_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .CLR(SR),
        .D(dht11_data_out_e_reg_1),
        .Q(dht11_data_out_e_reg_0));
  soc_dht11_myip_dht11_0_0_edge_detector_p dht_ed
       (.D({dht_ed_n_0,dht_ed_n_1,dht_ed_n_2,dht_ed_n_3,dht_ed_n_4,dht_ed_n_5,dht_ed_n_6,dht_ed_n_7}),
        .DI({dht_ed_n_8,dht_ed_n_9,dht_ed_n_10,dht_ed_n_11}),
        .E(p_0_in_0),
        .Q(temp_data),
        .S({dht_ed_n_63,dht_ed_n_64,dht_ed_n_65,dht_ed_n_66}),
        .data_count(data_count),
        .\data_count_reg[3] (\data_count[4]_i_4_n_0 ),
        .\data_count_reg[4] ({dht_ed_n_12,dht_ed_n_13,dht_ed_n_14,dht_ed_n_15,dht_ed_n_16,dht_ed_n_17}),
        .\data_count_reg[4]_0 (Q),
        .\data_count_reg[5] (\data_count[5]_i_6_n_0 ),
        .\data_count_reg[5]_0 (\data_count[5]_i_7_n_0 ),
        .dht11_data(dht11_data),
        .dht11_data_0(dht11_data_out_e_reg_0),
        .ff_cur_reg_0(dht_ed_n_18),
        .ff_cur_reg_1(dht_ed_n_19),
        .ff_cur_reg_2({p_1_in[5:3],p_1_in[0]}),
        .ff_old_reg_0(SR),
        .humidity1(humidity1),
        .\next_state_reg[0] (\state_reg[5]_0 ),
        .\next_state_reg[0]_0 (\next_state[5]_i_8_n_0 ),
        .\next_state_reg[5] (\next_state[5]_i_5_n_0 ),
        .\next_state_reg[5]_0 (\count_usec_reg[14]_0 ),
        .\next_state_reg[5]_1 (\next_state[5]_i_11_n_0 ),
        .\next_state_reg[5]_2 (\state_reg[0]_0 ),
        .read_state(read_state),
        .\read_state_reg[1] (\read_state[1]_i_2_n_0 ),
        .s00_axi_aclk(s00_axi_aclk),
        .s00_axi_aresetn(s00_axi_aresetn),
        .\state_reg[1] (\state_reg[1]_0 ),
        .\state_reg[3] (\state_reg[3]_0 ),
        .\temp_data_reg[0] (dht_ed_n_27),
        .\temp_data_reg[0]_0 (\temp_data[0]_i_2_n_0 ),
        .\temp_data_reg[0]_1 (\temp_data[0]_i_3_n_0 ),
        .\temp_data_reg[0]_2 (\temp_data[0]_i_4_n_0 ),
        .\temp_data_reg[35] ({dht_ed_n_67,dht_ed_n_68,dht_ed_n_69,dht_ed_n_70}),
        .\temp_data_reg[37] ({dht_ed_n_60,dht_ed_n_61,dht_ed_n_62}),
        .\temp_data_reg[38] ({p_1_in__0,p_0_in__0,p_0_in1_in,dht_ed_n_52,dht_ed_n_53,dht_ed_n_54,dht_ed_n_55,dht_ed_n_56,dht_ed_n_57,dht_ed_n_58,dht_ed_n_59}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 humidity1__2_carry
       (.CI(1'b0),
        .CO({humidity1__2_carry_n_0,humidity1__2_carry_n_1,humidity1__2_carry_n_2,humidity1__2_carry_n_3}),
        .CYINIT(1'b0),
        .DI({dht_ed_n_8,dht_ed_n_9,dht_ed_n_10,dht_ed_n_11}),
        .O(humidity1[3:0]),
        .S({dht_ed_n_67,dht_ed_n_68,dht_ed_n_69,dht_ed_n_70}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 humidity1__2_carry__0
       (.CI(humidity1__2_carry_n_0),
        .CO({NLW_humidity1__2_carry__0_CO_UNCONNECTED[3],humidity1__2_carry__0_n_1,humidity1__2_carry__0_n_2,humidity1__2_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,dht_ed_n_60,dht_ed_n_61,dht_ed_n_62}),
        .O(humidity1[7:4]),
        .S({dht_ed_n_63,dht_ed_n_64,dht_ed_n_65,dht_ed_n_66}));
  FDRE \humidity_reg[0] 
       (.C(s00_axi_aclk),
        .CE(dht_ed_n_27),
        .D(p_1_in__0[0]),
        .Q(\humidity_reg[7]_0 [0]),
        .R(1'b0));
  FDRE \humidity_reg[1] 
       (.C(s00_axi_aclk),
        .CE(dht_ed_n_27),
        .D(p_1_in__0[1]),
        .Q(\humidity_reg[7]_0 [1]),
        .R(1'b0));
  FDRE \humidity_reg[2] 
       (.C(s00_axi_aclk),
        .CE(dht_ed_n_27),
        .D(p_1_in__0[2]),
        .Q(\humidity_reg[7]_0 [2]),
        .R(1'b0));
  FDRE \humidity_reg[3] 
       (.C(s00_axi_aclk),
        .CE(dht_ed_n_27),
        .D(p_1_in__0[3]),
        .Q(\humidity_reg[7]_0 [3]),
        .R(1'b0));
  FDRE \humidity_reg[4] 
       (.C(s00_axi_aclk),
        .CE(dht_ed_n_27),
        .D(p_1_in__0[4]),
        .Q(\humidity_reg[7]_0 [4]),
        .R(1'b0));
  FDRE \humidity_reg[5] 
       (.C(s00_axi_aclk),
        .CE(dht_ed_n_27),
        .D(p_1_in__0[5]),
        .Q(\humidity_reg[7]_0 [5]),
        .R(1'b0));
  FDRE \humidity_reg[6] 
       (.C(s00_axi_aclk),
        .CE(dht_ed_n_27),
        .D(p_1_in__0[6]),
        .Q(\humidity_reg[7]_0 [6]),
        .R(1'b0));
  FDRE \humidity_reg[7] 
       (.C(s00_axi_aclk),
        .CE(dht_ed_n_27),
        .D(p_1_in__0[7]),
        .Q(\humidity_reg[7]_0 [7]),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h8)) 
    \next_state[1]_i_1 
       (.I0(\state_reg[5]_0 [0]),
        .I1(\next_state[5]_i_8_n_0 ),
        .O(p_1_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \next_state[2]_i_1 
       (.I0(\state_reg[5]_0 [1]),
        .I1(\next_state[5]_i_8_n_0 ),
        .O(p_1_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'h5D)) 
    \next_state[5]_i_11 
       (.I0(\next_state[5]_i_8_n_0 ),
        .I1(\state_reg[5]_0 [1]),
        .I2(dht11_data_out_e_i_5_n_0),
        .O(\next_state[5]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h4444444044444444)) 
    \next_state[5]_i_12 
       (.I0(\next_state[5]_i_13_n_0 ),
        .I1(count_usec_reg[8]),
        .I2(count_usec_reg[7]),
        .I3(count_usec_reg[6]),
        .I4(count_usec_reg[5]),
        .I5(\next_state[5]_i_14_n_0 ),
        .O(\next_state[5]_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \next_state[5]_i_13 
       (.I0(count_usec_reg[9]),
        .I1(count_usec_reg[10]),
        .O(\next_state[5]_i_13_n_0 ));
  LUT5 #(
    .INIT(32'h55555557)) 
    \next_state[5]_i_14 
       (.I0(count_usec_reg[4]),
        .I1(count_usec_reg[3]),
        .I2(count_usec_reg[2]),
        .I3(count_usec_reg[1]),
        .I4(count_usec_reg[0]),
        .O(\next_state[5]_i_14_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \next_state[5]_i_5 
       (.I0(\state_reg[5]_0 [2]),
        .I1(\state_reg[5]_0 [4]),
        .O(\next_state[5]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFDDDDDDDDD)) 
    \next_state[5]_i_6 
       (.I0(\temp_data[0]_i_4_n_0 ),
        .I1(count_usec_reg[14]),
        .I2(count_usec_reg[12]),
        .I3(count_usec_reg[11]),
        .I4(\next_state[5]_i_12_n_0 ),
        .I5(count_usec_reg[13]),
        .O(\count_usec_reg[14]_0 ));
  LUT6 #(
    .INIT(64'h0000000100010116)) 
    \next_state[5]_i_8 
       (.I0(\state_reg[5]_0 [0]),
        .I1(\state_reg[5]_0 [1]),
        .I2(\state_reg[5]_0 [2]),
        .I3(\state_reg[5]_0 [3]),
        .I4(\state_reg[5]_0 [4]),
        .I5(\state_reg[5]_0 [5]),
        .O(\next_state[5]_i_8_n_0 ));
  FDPE \next_state_reg[0] 
       (.C(s00_axi_aclk),
        .CE(p_0_in_0),
        .D(p_1_in[0]),
        .PRE(SR),
        .Q(next_state[0]));
  FDCE \next_state_reg[1] 
       (.C(s00_axi_aclk),
        .CE(p_0_in_0),
        .CLR(SR),
        .D(p_1_in[1]),
        .Q(next_state[1]));
  FDCE \next_state_reg[2] 
       (.C(s00_axi_aclk),
        .CE(p_0_in_0),
        .CLR(SR),
        .D(p_1_in[2]),
        .Q(next_state[2]));
  FDCE \next_state_reg[3] 
       (.C(s00_axi_aclk),
        .CE(p_0_in_0),
        .CLR(SR),
        .D(p_1_in[3]),
        .Q(next_state[3]));
  FDCE \next_state_reg[4] 
       (.C(s00_axi_aclk),
        .CE(p_0_in_0),
        .CLR(SR),
        .D(p_1_in[4]),
        .Q(next_state[4]));
  FDCE \next_state_reg[5] 
       (.C(s00_axi_aclk),
        .CE(p_0_in_0),
        .CLR(SR),
        .D(p_1_in[5]),
        .Q(next_state[5]));
  LUT6 #(
    .INIT(64'hBBBBBBBBBBBBABAA)) 
    \read_state[1]_i_2 
       (.I0(\read_state[1]_i_3_n_0 ),
        .I1(\read_state[1]_i_4_n_0 ),
        .I2(\read_state[1]_i_5_n_0 ),
        .I3(\read_state[1]_i_6_n_0 ),
        .I4(\read_state[1]_i_7_n_0 ),
        .I5(\read_state[1]_i_8_n_0 ),
        .O(\read_state[1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \read_state[1]_i_3 
       (.I0(count_usec_reg[17]),
        .I1(count_usec_reg[19]),
        .I2(count_usec_reg[20]),
        .I3(count_usec_reg[18]),
        .I4(count_usec_reg[21]),
        .O(\read_state[1]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h7)) 
    \read_state[1]_i_4 
       (.I0(count_usec_reg[15]),
        .I1(count_usec_reg[16]),
        .O(\read_state[1]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h1FFFFFFF)) 
    \read_state[1]_i_5 
       (.I0(count_usec_reg[6]),
        .I1(count_usec_reg[5]),
        .I2(count_usec_reg[9]),
        .I3(count_usec_reg[10]),
        .I4(count_usec_reg[7]),
        .O(\read_state[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \read_state[1]_i_6 
       (.I0(count_usec_reg[1]),
        .I1(count_usec_reg[2]),
        .I2(count_usec_reg[3]),
        .I3(count_usec_reg[0]),
        .I4(count_usec_reg[4]),
        .I5(count_usec_reg[6]),
        .O(\read_state[1]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \read_state[1]_i_7 
       (.I0(count_usec_reg[14]),
        .I1(count_usec_reg[13]),
        .I2(count_usec_reg[11]),
        .I3(count_usec_reg[12]),
        .O(\read_state[1]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \read_state[1]_i_8 
       (.I0(count_usec_reg[8]),
        .I1(count_usec_reg[10]),
        .I2(count_usec_reg[9]),
        .O(\read_state[1]_i_8_n_0 ));
  (* FSM_ENCODED_STATES = "S_WAIT_NEDGE:10,S_WAIT_PEDGE:01" *) 
  FDPE \read_state_reg[0] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(dht_ed_n_19),
        .PRE(SR),
        .Q(read_state[0]));
  (* FSM_ENCODED_STATES = "S_WAIT_NEDGE:10,S_WAIT_PEDGE:01" *) 
  FDCE \read_state_reg[1] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .CLR(SR),
        .D(dht_ed_n_18),
        .Q(read_state[1]));
  (* FSM_ENCODED_STATES = "S_LOW_18MS:000010,S_HIGH_20US:000100,S_LOW_80US:001000,S_HIGH_80US:010000,S_IDLE:000001,S_READ_DATA:100000" *) 
  FDPE #(
    .IS_C_INVERTED(1'b1)) 
    \state_reg[0] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(next_state[0]),
        .PRE(SR),
        .Q(\state_reg[5]_0 [0]));
  (* FSM_ENCODED_STATES = "S_LOW_18MS:000010,S_HIGH_20US:000100,S_LOW_80US:001000,S_HIGH_80US:010000,S_IDLE:000001,S_READ_DATA:100000" *) 
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \state_reg[1] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .CLR(SR),
        .D(next_state[1]),
        .Q(\state_reg[5]_0 [1]));
  (* FSM_ENCODED_STATES = "S_LOW_18MS:000010,S_HIGH_20US:000100,S_LOW_80US:001000,S_HIGH_80US:010000,S_IDLE:000001,S_READ_DATA:100000" *) 
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \state_reg[2] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .CLR(SR),
        .D(next_state[2]),
        .Q(\state_reg[5]_0 [2]));
  (* FSM_ENCODED_STATES = "S_LOW_18MS:000010,S_HIGH_20US:000100,S_LOW_80US:001000,S_HIGH_80US:010000,S_IDLE:000001,S_READ_DATA:100000" *) 
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \state_reg[3] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .CLR(SR),
        .D(next_state[3]),
        .Q(\state_reg[5]_0 [3]));
  (* FSM_ENCODED_STATES = "S_LOW_18MS:000010,S_HIGH_20US:000100,S_LOW_80US:001000,S_HIGH_80US:010000,S_IDLE:000001,S_READ_DATA:100000" *) 
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \state_reg[4] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .CLR(SR),
        .D(next_state[4]),
        .Q(\state_reg[5]_0 [4]));
  (* FSM_ENCODED_STATES = "S_LOW_18MS:000010,S_HIGH_20US:000100,S_LOW_80US:001000,S_HIGH_80US:010000,S_IDLE:000001,S_READ_DATA:100000" *) 
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \state_reg[5] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .CLR(SR),
        .D(next_state[5]),
        .Q(\state_reg[5]_0 [5]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \temp_data[0]_i_2 
       (.I0(count_usec_reg[8]),
        .I1(count_usec_reg[7]),
        .I2(count_usec_reg[6]),
        .I3(count_usec_reg[9]),
        .I4(count_usec_reg[10]),
        .O(\temp_data[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEAEAEAEAEAEAEAAA)) 
    \temp_data[0]_i_3 
       (.I0(\read_state[1]_i_7_n_0 ),
        .I1(count_usec_reg[4]),
        .I2(count_usec_reg[5]),
        .I3(count_usec_reg[3]),
        .I4(count_usec_reg[2]),
        .I5(count_usec_reg[1]),
        .O(\temp_data[0]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \temp_data[0]_i_4 
       (.I0(count_usec_reg[16]),
        .I1(count_usec_reg[15]),
        .I2(\read_state[1]_i_3_n_0 ),
        .O(\temp_data[0]_i_4_n_0 ));
  FDCE \temp_data_reg[0] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_59),
        .Q(temp_data[0]));
  FDCE \temp_data_reg[10] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_0_in1_in[2]),
        .Q(temp_data[10]));
  FDCE \temp_data_reg[11] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_0_in1_in[3]),
        .Q(temp_data[11]));
  FDCE \temp_data_reg[12] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_0_in1_in[4]),
        .Q(temp_data[12]));
  FDCE \temp_data_reg[13] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_0_in1_in[5]),
        .Q(temp_data[13]));
  FDCE \temp_data_reg[14] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_0_in1_in[6]),
        .Q(temp_data[14]));
  FDCE \temp_data_reg[15] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_0_in1_in[7]),
        .Q(temp_data[15]));
  FDCE \temp_data_reg[16] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_7),
        .Q(temp_data[16]));
  FDCE \temp_data_reg[17] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_6),
        .Q(temp_data[17]));
  FDCE \temp_data_reg[18] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_5),
        .Q(temp_data[18]));
  FDCE \temp_data_reg[19] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_4),
        .Q(temp_data[19]));
  FDCE \temp_data_reg[1] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_58),
        .Q(temp_data[1]));
  FDCE \temp_data_reg[20] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_3),
        .Q(temp_data[20]));
  FDCE \temp_data_reg[21] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_2),
        .Q(temp_data[21]));
  FDCE \temp_data_reg[22] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_1),
        .Q(temp_data[22]));
  FDCE \temp_data_reg[23] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_0),
        .Q(temp_data[23]));
  FDCE \temp_data_reg[24] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_0_in__0[0]),
        .Q(temp_data[24]));
  FDCE \temp_data_reg[25] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_0_in__0[1]),
        .Q(temp_data[25]));
  FDCE \temp_data_reg[26] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_0_in__0[2]),
        .Q(temp_data[26]));
  FDCE \temp_data_reg[27] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_0_in__0[3]),
        .Q(temp_data[27]));
  FDCE \temp_data_reg[28] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_0_in__0[4]),
        .Q(temp_data[28]));
  FDCE \temp_data_reg[29] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_0_in__0[5]),
        .Q(temp_data[29]));
  FDCE \temp_data_reg[2] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_57),
        .Q(temp_data[2]));
  FDCE \temp_data_reg[30] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_0_in__0[6]),
        .Q(temp_data[30]));
  FDCE \temp_data_reg[31] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_0_in__0[7]),
        .Q(temp_data[31]));
  FDCE \temp_data_reg[32] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_1_in__0[0]),
        .Q(temp_data[32]));
  FDCE \temp_data_reg[33] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_1_in__0[1]),
        .Q(temp_data[33]));
  FDCE \temp_data_reg[34] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_1_in__0[2]),
        .Q(temp_data[34]));
  FDCE \temp_data_reg[35] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_1_in__0[3]),
        .Q(temp_data[35]));
  FDCE \temp_data_reg[36] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_1_in__0[4]),
        .Q(temp_data[36]));
  FDCE \temp_data_reg[37] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_1_in__0[5]),
        .Q(temp_data[37]));
  FDCE \temp_data_reg[38] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_1_in__0[6]),
        .Q(temp_data[38]));
  FDCE \temp_data_reg[39] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_1_in__0[7]),
        .Q(temp_data[39]));
  FDCE \temp_data_reg[3] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_56),
        .Q(temp_data[3]));
  FDCE \temp_data_reg[4] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_55),
        .Q(temp_data[4]));
  FDCE \temp_data_reg[5] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_54),
        .Q(temp_data[5]));
  FDCE \temp_data_reg[6] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_53),
        .Q(temp_data[6]));
  FDCE \temp_data_reg[7] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(dht_ed_n_52),
        .Q(temp_data[7]));
  FDCE \temp_data_reg[8] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_0_in1_in[0]),
        .Q(temp_data[8]));
  FDCE \temp_data_reg[9] 
       (.C(s00_axi_aclk),
        .CE(data_count),
        .CLR(SR),
        .D(p_0_in1_in[1]),
        .Q(temp_data[9]));
  FDRE \temperature_reg[0] 
       (.C(s00_axi_aclk),
        .CE(dht_ed_n_27),
        .D(dht_ed_n_7),
        .Q(\temperature_reg[7]_0 [0]),
        .R(1'b0));
  FDRE \temperature_reg[1] 
       (.C(s00_axi_aclk),
        .CE(dht_ed_n_27),
        .D(dht_ed_n_6),
        .Q(\temperature_reg[7]_0 [1]),
        .R(1'b0));
  FDRE \temperature_reg[2] 
       (.C(s00_axi_aclk),
        .CE(dht_ed_n_27),
        .D(dht_ed_n_5),
        .Q(\temperature_reg[7]_0 [2]),
        .R(1'b0));
  FDRE \temperature_reg[3] 
       (.C(s00_axi_aclk),
        .CE(dht_ed_n_27),
        .D(dht_ed_n_4),
        .Q(\temperature_reg[7]_0 [3]),
        .R(1'b0));
  FDRE \temperature_reg[4] 
       (.C(s00_axi_aclk),
        .CE(dht_ed_n_27),
        .D(dht_ed_n_3),
        .Q(\temperature_reg[7]_0 [4]),
        .R(1'b0));
  FDRE \temperature_reg[5] 
       (.C(s00_axi_aclk),
        .CE(dht_ed_n_27),
        .D(dht_ed_n_2),
        .Q(\temperature_reg[7]_0 [5]),
        .R(1'b0));
  FDRE \temperature_reg[6] 
       (.C(s00_axi_aclk),
        .CE(dht_ed_n_27),
        .D(dht_ed_n_1),
        .Q(\temperature_reg[7]_0 [6]),
        .R(1'b0));
  FDRE \temperature_reg[7] 
       (.C(s00_axi_aclk),
        .CE(dht_ed_n_27),
        .D(dht_ed_n_0),
        .Q(\temperature_reg[7]_0 [7]),
        .R(1'b0));
  soc_dht11_myip_dht11_0_0_clock_div_100 us_clk
       (.O({us_clk_n_4,us_clk_n_5,us_clk_n_6,us_clk_n_7}),
        .clk_div_100(clk_div_100),
        .clk_div_100_reg_0(clk_div_100_reg),
        .\cnt_sysclk_reg[5]_0 (\cnt_sysclk_reg[5] ),
        .count_usec_reg(count_usec_reg),
        .\count_usec_reg[11] ({us_clk_n_12,us_clk_n_13,us_clk_n_14,us_clk_n_15}),
        .\count_usec_reg[15] ({us_clk_n_16,us_clk_n_17,us_clk_n_18,us_clk_n_19}),
        .\count_usec_reg[19] ({us_clk_n_20,us_clk_n_21,us_clk_n_22,us_clk_n_23}),
        .\count_usec_reg[21] ({us_clk_n_24,us_clk_n_25}),
        .\count_usec_reg[7] ({us_clk_n_8,us_clk_n_9,us_clk_n_10,us_clk_n_11}),
        .count_usec_reg_0_sp_1(count_usec_e_reg_0),
        .ff_old_reg(us_clk_n_2),
        .s00_axi_aclk(s00_axi_aclk),
        .s00_axi_aresetn(s00_axi_aresetn),
        .s00_axi_aresetn_0(SR));
endmodule

(* ORIG_REF_NAME = "edge_detector_p" *) 
module soc_dht11_myip_dht11_0_0_edge_detector_p
   (D,
    DI,
    \data_count_reg[4] ,
    ff_cur_reg_0,
    ff_cur_reg_1,
    \state_reg[1] ,
    E,
    ff_cur_reg_2,
    \state_reg[3] ,
    \temp_data_reg[0] ,
    \temp_data_reg[38] ,
    \temp_data_reg[37] ,
    S,
    \temp_data_reg[35] ,
    dht11_data,
    s00_axi_aclk,
    ff_old_reg_0,
    Q,
    \data_count_reg[4]_0 ,
    \data_count_reg[3] ,
    \next_state_reg[0] ,
    read_state,
    \read_state_reg[1] ,
    data_count,
    dht11_data_0,
    \next_state_reg[5] ,
    \next_state_reg[5]_0 ,
    \next_state_reg[0]_0 ,
    humidity1,
    s00_axi_aresetn,
    \data_count_reg[5] ,
    \temp_data_reg[0]_0 ,
    \temp_data_reg[0]_1 ,
    \temp_data_reg[0]_2 ,
    \data_count_reg[5]_0 ,
    \next_state_reg[5]_1 ,
    \next_state_reg[5]_2 );
  output [7:0]D;
  output [3:0]DI;
  output [5:0]\data_count_reg[4] ;
  output ff_cur_reg_0;
  output ff_cur_reg_1;
  output \state_reg[1] ;
  output [0:0]E;
  output [3:0]ff_cur_reg_2;
  output \state_reg[3] ;
  output [0:0]\temp_data_reg[0] ;
  output [31:0]\temp_data_reg[38] ;
  output [2:0]\temp_data_reg[37] ;
  output [3:0]S;
  output [3:0]\temp_data_reg[35] ;
  inout dht11_data;
  input s00_axi_aclk;
  input ff_old_reg_0;
  input [39:0]Q;
  input [5:0]\data_count_reg[4]_0 ;
  input \data_count_reg[3] ;
  input [5:0]\next_state_reg[0] ;
  input [1:0]read_state;
  input \read_state_reg[1] ;
  input data_count;
  input dht11_data_0;
  input \next_state_reg[5] ;
  input \next_state_reg[5]_0 ;
  input \next_state_reg[0]_0 ;
  input [7:0]humidity1;
  input s00_axi_aresetn;
  input \data_count_reg[5] ;
  input \temp_data_reg[0]_0 ;
  input \temp_data_reg[0]_1 ;
  input \temp_data_reg[0]_2 ;
  input \data_count_reg[5]_0 ;
  input \next_state_reg[5]_1 ;
  input \next_state_reg[5]_2 ;

  wire [7:0]D;
  wire [3:0]DI;
  wire [0:0]E;
  wire [39:0]Q;
  wire [3:0]S;
  wire count_usec_e_i_6_n_0;
  wire count_usec_e_i_7_n_0;
  wire data_count;
  wire \data_count[2]_i_2_n_0 ;
  wire \data_count[3]_i_2_n_0 ;
  wire \data_count[4]_i_2_n_0 ;
  wire \data_count[4]_i_3_n_0 ;
  wire \data_count[5]_i_4_n_0 ;
  wire \data_count[5]_i_5_n_0 ;
  wire \data_count_reg[3] ;
  wire [5:0]\data_count_reg[4] ;
  wire [5:0]\data_count_reg[4]_0 ;
  wire \data_count_reg[5] ;
  wire \data_count_reg[5]_0 ;
  wire dht11_data;
  wire dht11_data_0;
  wire ff_cur_reg_0;
  wire ff_cur_reg_1;
  wire [3:0]ff_cur_reg_2;
  wire ff_old_reg_0;
  wire [7:0]humidity1;
  wire humidity1__2_carry__0_i_10_n_0;
  wire humidity1__2_carry__0_i_11_n_0;
  wire humidity1__2_carry__0_i_12_n_0;
  wire humidity1__2_carry__0_i_13_n_0;
  wire humidity1__2_carry__0_i_14_n_0;
  wire humidity1__2_carry__0_i_15_n_0;
  wire humidity1__2_carry__0_i_8_n_0;
  wire humidity1__2_carry__0_i_9_n_0;
  wire humidity1__2_carry_i_10_n_0;
  wire humidity1__2_carry_i_11_n_0;
  wire humidity1__2_carry_i_12_n_0;
  wire humidity1__2_carry_i_13_n_0;
  wire humidity1__2_carry_i_9_n_0;
  wire \humidity[7]_i_2_n_0 ;
  wire \humidity[7]_i_3_n_0 ;
  wire \humidity[7]_i_4_n_0 ;
  wire \humidity[7]_i_5_n_0 ;
  wire \humidity[7]_i_6_n_0 ;
  wire \humidity[7]_i_7_n_0 ;
  wire \humidity[7]_i_8_n_0 ;
  wire \next_state[5]_i_10_n_0 ;
  wire \next_state[5]_i_3_n_0 ;
  wire \next_state[5]_i_4_n_0 ;
  wire \next_state[5]_i_7_n_0 ;
  wire \next_state[5]_i_9_n_0 ;
  wire [5:0]\next_state_reg[0] ;
  wire \next_state_reg[0]_0 ;
  wire \next_state_reg[5] ;
  wire \next_state_reg[5]_0 ;
  wire \next_state_reg[5]_1 ;
  wire \next_state_reg[5]_2 ;
  wire [1:0]p_0_in;
  wire [1:0]read_state;
  wire \read_state_reg[1] ;
  wire s00_axi_aclk;
  wire s00_axi_aresetn;
  wire \state_reg[1] ;
  wire \state_reg[3] ;
  wire [0:0]\temp_data_reg[0] ;
  wire \temp_data_reg[0]_0 ;
  wire \temp_data_reg[0]_1 ;
  wire \temp_data_reg[0]_2 ;
  wire [3:0]\temp_data_reg[35] ;
  wire [2:0]\temp_data_reg[37] ;
  wire [31:0]\temp_data_reg[38] ;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hFBFBFB8A)) 
    count_usec_e_i_2
       (.I0(\next_state_reg[0] [3]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(\next_state_reg[0] [2]),
        .I4(\next_state_reg[0] [4]),
        .O(\state_reg[3] ));
  LUT6 #(
    .INIT(64'hFDFDFDFDFDFDFDC3)) 
    count_usec_e_i_4
       (.I0(count_usec_e_i_6_n_0),
        .I1(\next_state_reg[0] [1]),
        .I2(\next_state_reg[0] [0]),
        .I3(\next_state_reg[5] ),
        .I4(\next_state_reg[0] [3]),
        .I5(\next_state_reg[0] [5]),
        .O(\state_reg[1] ));
  LUT5 #(
    .INIT(32'h01570003)) 
    count_usec_e_i_6
       (.I0(\next_state_reg[0] [2]),
        .I1(\next_state_reg[0] [5]),
        .I2(\next_state_reg[0] [4]),
        .I3(\next_state_reg[0] [3]),
        .I4(count_usec_e_i_7_n_0),
        .O(count_usec_e_i_6_n_0));
  LUT6 #(
    .INIT(64'h04140004FFFFFFFF)) 
    count_usec_e_i_7
       (.I0(\next_state_reg[0] [4]),
        .I1(read_state[1]),
        .I2(read_state[0]),
        .I3(p_0_in[0]),
        .I4(p_0_in[1]),
        .I5(\next_state_reg[0] [5]),
        .O(count_usec_e_i_7_n_0));
  LUT4 #(
    .INIT(16'h0440)) 
    \data_count[0]_i_1 
       (.I0(\data_count[2]_i_2_n_0 ),
        .I1(\data_count[4]_i_2_n_0 ),
        .I2(\data_count[4]_i_3_n_0 ),
        .I3(\data_count_reg[4]_0 [0]),
        .O(\data_count_reg[4] [0]));
  LUT5 #(
    .INIT(32'h000074C4)) 
    \data_count[1]_i_1 
       (.I0(\data_count[3]_i_2_n_0 ),
        .I1(\data_count_reg[4]_0 [1]),
        .I2(\data_count[4]_i_3_n_0 ),
        .I3(\data_count_reg[4]_0 [0]),
        .I4(\data_count[2]_i_2_n_0 ),
        .O(\data_count_reg[4] [1]));
  LUT6 #(
    .INIT(64'h000000007FC05500)) 
    \data_count[2]_i_1 
       (.I0(\data_count[3]_i_2_n_0 ),
        .I1(\data_count_reg[4]_0 [1]),
        .I2(\data_count_reg[4]_0 [0]),
        .I3(\data_count_reg[4]_0 [2]),
        .I4(\data_count[4]_i_3_n_0 ),
        .I5(\data_count[2]_i_2_n_0 ),
        .O(\data_count_reg[4] [2]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \data_count[2]_i_2 
       (.I0(\data_count[5]_i_4_n_0 ),
        .I1(\data_count[5]_i_5_n_0 ),
        .O(\data_count[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h28EC0000)) 
    \data_count[3]_i_1 
       (.I0(\data_count[4]_i_3_n_0 ),
        .I1(\data_count_reg[4]_0 [3]),
        .I2(\data_count_reg[3] ),
        .I3(\data_count[3]_i_2_n_0 ),
        .I4(\data_count[5]_i_5_n_0 ),
        .O(\data_count_reg[4] [3]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h40404440)) 
    \data_count[3]_i_2 
       (.I0(read_state[0]),
        .I1(read_state[1]),
        .I2(\read_state_reg[1] ),
        .I3(p_0_in[0]),
        .I4(p_0_in[1]),
        .O(\data_count[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0440404040404040)) 
    \data_count[4]_i_1 
       (.I0(\data_count_reg[4]_0 [5]),
        .I1(\data_count[4]_i_2_n_0 ),
        .I2(\data_count_reg[4]_0 [4]),
        .I3(\data_count[4]_i_3_n_0 ),
        .I4(\data_count_reg[4]_0 [3]),
        .I5(\data_count_reg[3] ),
        .O(\data_count_reg[4] [4]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hDDFDFFFF)) 
    \data_count[4]_i_2 
       (.I0(read_state[1]),
        .I1(read_state[0]),
        .I2(p_0_in[0]),
        .I3(p_0_in[1]),
        .I4(\read_state_reg[1] ),
        .O(\data_count[4]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h0400)) 
    \data_count[4]_i_3 
       (.I0(p_0_in[1]),
        .I1(p_0_in[0]),
        .I2(read_state[0]),
        .I3(read_state[1]),
        .O(\data_count[4]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \data_count[5]_i_2 
       (.I0(\data_count[5]_i_4_n_0 ),
        .I1(\data_count[5]_i_5_n_0 ),
        .O(\data_count_reg[4] [5]));
  LUT6 #(
    .INIT(64'hB035307580150055)) 
    \data_count[5]_i_4 
       (.I0(\data_count_reg[4]_0 [4]),
        .I1(\next_state[5]_i_7_n_0 ),
        .I2(\data_count_reg[5] ),
        .I3(\data_count_reg[4]_0 [3]),
        .I4(\data_count_reg[3] ),
        .I5(\read_state_reg[1] ),
        .O(\data_count[5]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h8787FF0F0F0F0F0F)) 
    \data_count[5]_i_5 
       (.I0(\data_count_reg[5]_0 ),
        .I1(\data_count_reg[4]_0 [4]),
        .I2(\data_count_reg[4]_0 [5]),
        .I3(\read_state_reg[1] ),
        .I4(\next_state[5]_i_7_n_0 ),
        .I5(\data_count_reg[5] ),
        .O(\data_count[5]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    dht11_data_INST_0
       (.I0(1'b0),
        .I1(dht11_data_0),
        .I2(1'b0),
        .I3(1'b0),
        .I4(1'b0),
        .I5(1'b0),
        .O(dht11_data));
  FDCE ff_cur_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .CLR(ff_old_reg_0),
        .D(dht11_data),
        .Q(p_0_in[1]));
  FDCE ff_old_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .CLR(ff_old_reg_0),
        .D(p_0_in[1]),
        .Q(p_0_in[0]));
  LUT5 #(
    .INIT(32'hBBB222B2)) 
    humidity1__2_carry__0_i_1
       (.I0(humidity1__2_carry__0_i_8_n_0),
        .I1(humidity1__2_carry__0_i_9_n_0),
        .I2(Q[37]),
        .I3(\data_count[4]_i_3_n_0 ),
        .I4(Q[36]),
        .O(\temp_data_reg[37] [2]));
  LUT6 #(
    .INIT(64'hFFE2F322EEC0E200)) 
    humidity1__2_carry__0_i_10
       (.I0(Q[27]),
        .I1(\data_count[4]_i_3_n_0 ),
        .I2(Q[26]),
        .I3(D[3]),
        .I4(Q[10]),
        .I5(Q[11]),
        .O(humidity1__2_carry__0_i_10_n_0));
  LUT6 #(
    .INIT(64'h5AA53C3C5AA5C3C3)) 
    humidity1__2_carry__0_i_11
       (.I0(Q[11]),
        .I1(Q[12]),
        .I2(D[4]),
        .I3(Q[27]),
        .I4(\data_count[4]_i_3_n_0 ),
        .I5(Q[28]),
        .O(humidity1__2_carry__0_i_11_n_0));
  LUT6 #(
    .INIT(64'hFFE2F322EEC0E200)) 
    humidity1__2_carry__0_i_12
       (.I0(Q[29]),
        .I1(\data_count[4]_i_3_n_0 ),
        .I2(Q[28]),
        .I3(D[5]),
        .I4(Q[12]),
        .I5(Q[13]),
        .O(humidity1__2_carry__0_i_12_n_0));
  LUT6 #(
    .INIT(64'hB8748B47478B74B8)) 
    humidity1__2_carry__0_i_13
       (.I0(Q[14]),
        .I1(\data_count[4]_i_3_n_0 ),
        .I2(Q[15]),
        .I3(Q[22]),
        .I4(Q[23]),
        .I5(humidity1__2_carry__0_i_15_n_0),
        .O(humidity1__2_carry__0_i_13_n_0));
  LUT6 #(
    .INIT(64'h5AA53C3C5AA5C3C3)) 
    humidity1__2_carry__0_i_14
       (.I0(Q[13]),
        .I1(Q[14]),
        .I2(D[6]),
        .I3(Q[29]),
        .I4(\data_count[4]_i_3_n_0 ),
        .I5(Q[30]),
        .O(humidity1__2_carry__0_i_14_n_0));
  LUT5 #(
    .INIT(32'h335ACC5A)) 
    humidity1__2_carry__0_i_15
       (.I0(Q[39]),
        .I1(Q[38]),
        .I2(Q[31]),
        .I3(\data_count[4]_i_3_n_0 ),
        .I4(Q[30]),
        .O(humidity1__2_carry__0_i_15_n_0));
  LUT5 #(
    .INIT(32'hB2BBB222)) 
    humidity1__2_carry__0_i_2
       (.I0(humidity1__2_carry__0_i_10_n_0),
        .I1(humidity1__2_carry__0_i_11_n_0),
        .I2(Q[35]),
        .I3(\data_count[4]_i_3_n_0 ),
        .I4(Q[36]),
        .O(\temp_data_reg[37] [1]));
  LUT5 #(
    .INIT(32'hBBB222B2)) 
    humidity1__2_carry__0_i_3
       (.I0(humidity1__2_carry_i_12_n_0),
        .I1(humidity1__2_carry_i_13_n_0),
        .I2(Q[35]),
        .I3(\data_count[4]_i_3_n_0 ),
        .I4(Q[34]),
        .O(\temp_data_reg[37] [0]));
  LUT6 #(
    .INIT(64'hE8818117177E7EE8)) 
    humidity1__2_carry__0_i_4
       (.I0(humidity1__2_carry__0_i_12_n_0),
        .I1(\temp_data_reg[38] [30]),
        .I2(\temp_data_reg[38] [14]),
        .I3(\temp_data_reg[38] [22]),
        .I4(D[6]),
        .I5(humidity1__2_carry__0_i_13_n_0),
        .O(S[3]));
  LUT6 #(
    .INIT(64'h9699966669666999)) 
    humidity1__2_carry__0_i_5
       (.I0(\temp_data_reg[37] [2]),
        .I1(humidity1__2_carry__0_i_12_n_0),
        .I2(Q[37]),
        .I3(\data_count[4]_i_3_n_0 ),
        .I4(Q[38]),
        .I5(humidity1__2_carry__0_i_14_n_0),
        .O(S[2]));
  LUT6 #(
    .INIT(64'h9996669666699969)) 
    humidity1__2_carry__0_i_6
       (.I0(\temp_data_reg[37] [1]),
        .I1(humidity1__2_carry__0_i_8_n_0),
        .I2(Q[37]),
        .I3(\data_count[4]_i_3_n_0 ),
        .I4(Q[36]),
        .I5(humidity1__2_carry__0_i_9_n_0),
        .O(S[1]));
  LUT6 #(
    .INIT(64'h9699966669666999)) 
    humidity1__2_carry__0_i_7
       (.I0(\temp_data_reg[37] [0]),
        .I1(humidity1__2_carry__0_i_10_n_0),
        .I2(Q[35]),
        .I3(\data_count[4]_i_3_n_0 ),
        .I4(Q[36]),
        .I5(humidity1__2_carry__0_i_11_n_0),
        .O(S[0]));
  LUT6 #(
    .INIT(64'hFFEEF3E2E2C02200)) 
    humidity1__2_carry__0_i_8
       (.I0(Q[12]),
        .I1(\data_count[4]_i_3_n_0 ),
        .I2(Q[11]),
        .I3(Q[28]),
        .I4(Q[27]),
        .I5(D[4]),
        .O(humidity1__2_carry__0_i_8_n_0));
  LUT6 #(
    .INIT(64'h3CC35A5A3CC3A5A5)) 
    humidity1__2_carry__0_i_9
       (.I0(Q[13]),
        .I1(Q[12]),
        .I2(D[5]),
        .I3(Q[28]),
        .I4(\data_count[4]_i_3_n_0 ),
        .I5(Q[29]),
        .O(humidity1__2_carry__0_i_9_n_0));
  LUT5 #(
    .INIT(32'hBB2BB222)) 
    humidity1__2_carry_i_1
       (.I0(humidity1__2_carry_i_9_n_0),
        .I1(humidity1__2_carry_i_10_n_0),
        .I2(\data_count[4]_i_3_n_0 ),
        .I3(Q[33]),
        .I4(Q[34]),
        .O(DI[3]));
  LUT6 #(
    .INIT(64'h5AA53C3C5AA5C3C3)) 
    humidity1__2_carry_i_10
       (.I0(Q[9]),
        .I1(Q[10]),
        .I2(D[2]),
        .I3(Q[25]),
        .I4(\data_count[4]_i_3_n_0 ),
        .I5(Q[26]),
        .O(humidity1__2_carry_i_10_n_0));
  LUT6 #(
    .INIT(64'h5AA53C3C5AA5C3C3)) 
    humidity1__2_carry_i_11
       (.I0(Q[8]),
        .I1(Q[9]),
        .I2(D[1]),
        .I3(Q[24]),
        .I4(\data_count[4]_i_3_n_0 ),
        .I5(Q[25]),
        .O(humidity1__2_carry_i_11_n_0));
  LUT6 #(
    .INIT(64'hFFEEF3E2E2C02200)) 
    humidity1__2_carry_i_12
       (.I0(Q[10]),
        .I1(\data_count[4]_i_3_n_0 ),
        .I2(Q[9]),
        .I3(Q[26]),
        .I4(Q[25]),
        .I5(D[2]),
        .O(humidity1__2_carry_i_12_n_0));
  LUT6 #(
    .INIT(64'h3CC35A5A3CC3A5A5)) 
    humidity1__2_carry_i_13
       (.I0(Q[11]),
        .I1(Q[10]),
        .I2(D[3]),
        .I3(Q[26]),
        .I4(\data_count[4]_i_3_n_0 ),
        .I5(Q[27]),
        .O(humidity1__2_carry_i_13_n_0));
  LUT5 #(
    .INIT(32'h66996969)) 
    humidity1__2_carry_i_2
       (.I0(humidity1__2_carry_i_9_n_0),
        .I1(humidity1__2_carry_i_10_n_0),
        .I2(Q[34]),
        .I3(Q[33]),
        .I4(\data_count[4]_i_3_n_0 ),
        .O(DI[2]));
  LUT4 #(
    .INIT(16'hA959)) 
    humidity1__2_carry_i_3
       (.I0(humidity1__2_carry_i_11_n_0),
        .I1(Q[33]),
        .I2(\data_count[4]_i_3_n_0 ),
        .I3(Q[32]),
        .O(DI[1]));
  LUT6 #(
    .INIT(64'hC33CA5A5C33C5A5A)) 
    humidity1__2_carry_i_4
       (.I0(Q[8]),
        .I1(Q[7]),
        .I2(D[0]),
        .I3(Q[23]),
        .I4(\data_count[4]_i_3_n_0 ),
        .I5(Q[24]),
        .O(DI[0]));
  LUT6 #(
    .INIT(64'h9996669666699969)) 
    humidity1__2_carry_i_5
       (.I0(DI[3]),
        .I1(humidity1__2_carry_i_12_n_0),
        .I2(Q[35]),
        .I3(\data_count[4]_i_3_n_0 ),
        .I4(Q[34]),
        .I5(humidity1__2_carry_i_13_n_0),
        .O(\temp_data_reg[35] [3]));
  LUT6 #(
    .INIT(64'h9666666966696999)) 
    humidity1__2_carry_i_6
       (.I0(\temp_data_reg[38] [26]),
        .I1(humidity1__2_carry_i_10_n_0),
        .I2(\temp_data_reg[38] [9]),
        .I3(D[1]),
        .I4(\temp_data_reg[38] [17]),
        .I5(\temp_data_reg[38] [25]),
        .O(\temp_data_reg[35] [2]));
  LUT6 #(
    .INIT(64'h5656566A6A6A566A)) 
    humidity1__2_carry_i_7
       (.I0(DI[1]),
        .I1(D[0]),
        .I2(\temp_data_reg[38] [16]),
        .I3(Q[8]),
        .I4(\data_count[4]_i_3_n_0 ),
        .I5(Q[7]),
        .O(\temp_data_reg[35] [1]));
  LUT4 #(
    .INIT(16'h56A6)) 
    humidity1__2_carry_i_8
       (.I0(DI[0]),
        .I1(Q[32]),
        .I2(\data_count[4]_i_3_n_0 ),
        .I3(Q[31]),
        .O(\temp_data_reg[35] [0]));
  LUT6 #(
    .INIT(64'hFFFACFCACAC00A00)) 
    humidity1__2_carry_i_9
       (.I0(Q[9]),
        .I1(Q[8]),
        .I2(\data_count[4]_i_3_n_0 ),
        .I3(Q[25]),
        .I4(Q[24]),
        .I5(D[1]),
        .O(humidity1__2_carry_i_9_n_0));
  LUT6 #(
    .INIT(64'h0000000000000082)) 
    \humidity[7]_i_1 
       (.I0(\data_count[2]_i_2_n_0 ),
        .I1(humidity1[0]),
        .I2(\temp_data_reg[38] [0]),
        .I3(\humidity[7]_i_2_n_0 ),
        .I4(\humidity[7]_i_3_n_0 ),
        .I5(\humidity[7]_i_4_n_0 ),
        .O(\temp_data_reg[0] ));
  LUT5 #(
    .INIT(32'hFFFF77F7)) 
    \humidity[7]_i_2 
       (.I0(s00_axi_aresetn),
        .I1(data_count),
        .I2(\temp_data_reg[38] [2]),
        .I3(humidity1[2]),
        .I4(\humidity[7]_i_5_n_0 ),
        .O(\humidity[7]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAEAEFFAE)) 
    \humidity[7]_i_3 
       (.I0(\humidity[7]_i_6_n_0 ),
        .I1(humidity1[1]),
        .I2(\temp_data_reg[38] [1]),
        .I3(humidity1[5]),
        .I4(\temp_data_reg[38] [5]),
        .O(\humidity[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hEFEEFFFFEFEEEFEE)) 
    \humidity[7]_i_4 
       (.I0(\humidity[7]_i_7_n_0 ),
        .I1(\humidity[7]_i_8_n_0 ),
        .I2(humidity1[6]),
        .I3(\temp_data_reg[38] [6]),
        .I4(\temp_data_reg[38] [2]),
        .I5(humidity1[2]),
        .O(\humidity[7]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0F004F4FCFCC4444)) 
    \humidity[7]_i_5 
       (.I0(Q[4]),
        .I1(humidity1[4]),
        .I2(humidity1[3]),
        .I3(Q[2]),
        .I4(\data_count[4]_i_3_n_0 ),
        .I5(Q[3]),
        .O(\humidity[7]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h4F0C4FFF440C440C)) 
    \humidity[7]_i_6 
       (.I0(Q[5]),
        .I1(humidity1[6]),
        .I2(Q[6]),
        .I3(\data_count[4]_i_3_n_0 ),
        .I4(Q[7]),
        .I5(humidity1[7]),
        .O(\humidity[7]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
    \humidity[7]_i_7 
       (.I0(\temp_data_reg[38] [3]),
        .I1(humidity1[3]),
        .I2(\temp_data_reg[38] [5]),
        .I3(humidity1[5]),
        .I4(\temp_data_reg[38] [1]),
        .I5(humidity1[1]),
        .O(\humidity[7]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h4540FFFF45404540)) 
    \humidity[7]_i_8 
       (.I0(humidity1[4]),
        .I1(Q[3]),
        .I2(\data_count[4]_i_3_n_0 ),
        .I3(Q[4]),
        .I4(humidity1[7]),
        .I5(\temp_data_reg[38] [7]),
        .O(\humidity[7]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFB8AFFFF)) 
    \next_state[0]_i_1 
       (.I0(\next_state_reg[5] ),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(\next_state_reg[0] [3]),
        .I4(\next_state_reg[0]_0 ),
        .I5(\next_state_reg[0] [5]),
        .O(ff_cur_reg_2[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \next_state[3]_i_1 
       (.I0(p_0_in[1]),
        .I1(p_0_in[0]),
        .I2(\next_state_reg[0]_0 ),
        .I3(\next_state_reg[0] [2]),
        .O(ff_cur_reg_2[1]));
  LUT4 #(
    .INIT(16'h4000)) 
    \next_state[4]_i_1 
       (.I0(p_0_in[0]),
        .I1(p_0_in[1]),
        .I2(\next_state_reg[0]_0 ),
        .I3(\next_state_reg[0] [3]),
        .O(ff_cur_reg_2[2]));
  LUT6 #(
    .INIT(64'hFFF4FFF4FFF4F4F4)) 
    \next_state[5]_i_1 
       (.I0(\next_state[5]_i_3_n_0 ),
        .I1(\next_state_reg[0] [5]),
        .I2(\next_state[5]_i_4_n_0 ),
        .I3(\next_state_reg[5] ),
        .I4(\next_state_reg[5]_0 ),
        .I5(\next_state[5]_i_7_n_0 ),
        .O(E));
  LUT6 #(
    .INIT(64'hF0F03CF0F0F050F0)) 
    \next_state[5]_i_10 
       (.I0(\read_state_reg[1] ),
        .I1(\data_count_reg[3] ),
        .I2(\data_count_reg[4]_0 [3]),
        .I3(read_state[1]),
        .I4(read_state[0]),
        .I5(\next_state[5]_i_7_n_0 ),
        .O(\next_state[5]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \next_state[5]_i_2 
       (.I0(p_0_in[1]),
        .I1(p_0_in[0]),
        .I2(\next_state_reg[0]_0 ),
        .I3(\next_state_reg[0] [4]),
        .O(ff_cur_reg_2[3]));
  LUT5 #(
    .INIT(32'h87009F00)) 
    \next_state[5]_i_3 
       (.I0(\next_state[5]_i_9_n_0 ),
        .I1(\data_count_reg[4]_0 [4]),
        .I2(\data_count_reg[4]_0 [5]),
        .I3(\data_count[4]_i_2_n_0 ),
        .I4(\next_state[5]_i_10_n_0 ),
        .O(\next_state[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFF400)) 
    \next_state[5]_i_4 
       (.I0(p_0_in[0]),
        .I1(p_0_in[1]),
        .I2(\next_state_reg[5]_0 ),
        .I3(\next_state_reg[0] [3]),
        .I4(\next_state_reg[5]_1 ),
        .I5(\next_state_reg[5]_2 ),
        .O(\next_state[5]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \next_state[5]_i_7 
       (.I0(p_0_in[0]),
        .I1(p_0_in[1]),
        .O(\next_state[5]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h80000000)) 
    \next_state[5]_i_9 
       (.I0(\data_count_reg[4]_0 [1]),
        .I1(\data_count_reg[4]_0 [0]),
        .I2(\data_count_reg[4]_0 [2]),
        .I3(\data_count_reg[4]_0 [3]),
        .I4(\data_count[4]_i_3_n_0 ),
        .O(\next_state[5]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hFFDDFFFFF4000000)) 
    \read_state[0]_i_1 
       (.I0(p_0_in[1]),
        .I1(p_0_in[0]),
        .I2(\read_state_reg[1] ),
        .I3(read_state[1]),
        .I4(data_count),
        .I5(read_state[0]),
        .O(ff_cur_reg_1));
  LUT6 #(
    .INIT(64'hFF22FF000B00FF00)) 
    \read_state[1]_i_1 
       (.I0(p_0_in[1]),
        .I1(p_0_in[0]),
        .I2(\read_state_reg[1] ),
        .I3(read_state[1]),
        .I4(data_count),
        .I5(read_state[0]),
        .O(ff_cur_reg_0));
  LUT5 #(
    .INIT(32'hEEE2EEEE)) 
    \temp_data[0]_i_1 
       (.I0(Q[0]),
        .I1(\data_count[4]_i_3_n_0 ),
        .I2(\temp_data_reg[0]_0 ),
        .I3(\temp_data_reg[0]_1 ),
        .I4(\temp_data_reg[0]_2 ),
        .O(\temp_data_reg[38] [0]));
  LUT6 #(
    .INIT(64'hAABAAAAAAA8AAAAA)) 
    \temp_data[10]_i_1 
       (.I0(Q[10]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[9]),
        .O(\temp_data_reg[38] [10]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[11]_i_1 
       (.I0(Q[10]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[11]),
        .O(\temp_data_reg[38] [11]));
  LUT6 #(
    .INIT(64'hAABAAAAAAA8AAAAA)) 
    \temp_data[12]_i_1 
       (.I0(Q[12]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[11]),
        .O(\temp_data_reg[38] [12]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[13]_i_1 
       (.I0(Q[12]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[13]),
        .O(\temp_data_reg[38] [13]));
  LUT6 #(
    .INIT(64'hAABAAAAAAA8AAAAA)) 
    \temp_data[14]_i_1 
       (.I0(Q[14]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[13]),
        .O(\temp_data_reg[38] [14]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[15]_i_1 
       (.I0(Q[14]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[15]),
        .O(\temp_data_reg[38] [15]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[16]_i_1 
       (.I0(Q[15]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[16]),
        .O(D[0]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[17]_i_1 
       (.I0(Q[16]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[17]),
        .O(D[1]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[18]_i_1 
       (.I0(Q[17]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[18]),
        .O(D[2]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[19]_i_1 
       (.I0(Q[18]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[19]),
        .O(D[3]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[1]_i_1 
       (.I0(Q[0]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[1]),
        .O(\temp_data_reg[38] [1]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[20]_i_1 
       (.I0(Q[19]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[20]),
        .O(D[4]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[21]_i_1 
       (.I0(Q[20]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[21]),
        .O(D[5]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[22]_i_1 
       (.I0(Q[21]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[22]),
        .O(D[6]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[23]_i_1 
       (.I0(Q[22]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[23]),
        .O(D[7]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[24]_i_1 
       (.I0(Q[23]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[24]),
        .O(\temp_data_reg[38] [16]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[25]_i_1 
       (.I0(Q[24]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[25]),
        .O(\temp_data_reg[38] [17]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[26]_i_1 
       (.I0(Q[25]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[26]),
        .O(\temp_data_reg[38] [18]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[27]_i_1 
       (.I0(Q[26]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[27]),
        .O(\temp_data_reg[38] [19]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[28]_i_1 
       (.I0(Q[27]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[28]),
        .O(\temp_data_reg[38] [20]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[29]_i_1 
       (.I0(Q[28]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[29]),
        .O(\temp_data_reg[38] [21]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[2]_i_1 
       (.I0(Q[1]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[2]),
        .O(\temp_data_reg[38] [2]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[30]_i_1 
       (.I0(Q[29]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[30]),
        .O(\temp_data_reg[38] [22]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[31]_i_1 
       (.I0(Q[30]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[31]),
        .O(\temp_data_reg[38] [23]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[32]_i_1 
       (.I0(Q[31]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[32]),
        .O(\temp_data_reg[38] [24]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[33]_i_1 
       (.I0(Q[32]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[33]),
        .O(\temp_data_reg[38] [25]));
  LUT6 #(
    .INIT(64'hAAAAACAAAAAAAAAA)) 
    \temp_data[34]_i_1 
       (.I0(Q[34]),
        .I1(Q[33]),
        .I2(p_0_in[1]),
        .I3(p_0_in[0]),
        .I4(read_state[0]),
        .I5(read_state[1]),
        .O(\temp_data_reg[38] [26]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[35]_i_1 
       (.I0(Q[34]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[35]),
        .O(\temp_data_reg[38] [27]));
  LUT6 #(
    .INIT(64'hAABAAAAAAA8AAAAA)) 
    \temp_data[36]_i_1 
       (.I0(Q[36]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[35]),
        .O(\temp_data_reg[38] [28]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[37]_i_1 
       (.I0(Q[36]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[37]),
        .O(\temp_data_reg[38] [29]));
  LUT6 #(
    .INIT(64'hAABAAAAAAA8AAAAA)) 
    \temp_data[38]_i_1 
       (.I0(Q[38]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[37]),
        .O(\temp_data_reg[38] [30]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[39]_i_1 
       (.I0(Q[38]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[39]),
        .O(\temp_data_reg[38] [31]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[3]_i_1 
       (.I0(Q[2]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[3]),
        .O(\temp_data_reg[38] [3]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[4]_i_1 
       (.I0(Q[3]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[4]),
        .O(\temp_data_reg[38] [4]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[5]_i_1 
       (.I0(Q[4]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[5]),
        .O(\temp_data_reg[38] [5]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[6]_i_1 
       (.I0(Q[5]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[6]),
        .O(\temp_data_reg[38] [6]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[7]_i_1 
       (.I0(Q[6]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[7]),
        .O(\temp_data_reg[38] [7]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \temp_data[8]_i_1 
       (.I0(Q[7]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(read_state[0]),
        .I4(read_state[1]),
        .I5(Q[8]),
        .O(\temp_data_reg[38] [8]));
  LUT6 #(
    .INIT(64'hAAAAACAAAAAAAAAA)) 
    \temp_data[9]_i_1 
       (.I0(Q[9]),
        .I1(Q[8]),
        .I2(p_0_in[1]),
        .I3(p_0_in[0]),
        .I4(read_state[0]),
        .I5(read_state[1]),
        .O(\temp_data_reg[38] [9]));
endmodule

(* ORIG_REF_NAME = "edge_detector_p" *) 
module soc_dht11_myip_dht11_0_0_edge_detector_p_0
   (s00_axi_aresetn_0,
    ff_old_reg_0,
    O,
    \count_usec_reg[7] ,
    \count_usec_reg[11] ,
    \count_usec_reg[15] ,
    \count_usec_reg[19] ,
    \count_usec_reg[21] ,
    clk_div_100,
    s00_axi_aclk,
    count_usec_reg_0_sp_1,
    count_usec_reg,
    s00_axi_aresetn);
  output s00_axi_aresetn_0;
  output ff_old_reg_0;
  output [3:0]O;
  output [3:0]\count_usec_reg[7] ;
  output [3:0]\count_usec_reg[11] ;
  output [3:0]\count_usec_reg[15] ;
  output [3:0]\count_usec_reg[19] ;
  output [1:0]\count_usec_reg[21] ;
  input clk_div_100;
  input s00_axi_aclk;
  input count_usec_reg_0_sp_1;
  input [21:0]count_usec_reg;
  input s00_axi_aresetn;

  wire [3:0]O;
  wire clk_div_100;
  wire count_usec1;
  wire \count_usec[0]_i_4_n_0 ;
  wire \count_usec[0]_i_5_n_0 ;
  wire \count_usec[0]_i_6_n_0 ;
  wire \count_usec[0]_i_7_n_0 ;
  wire \count_usec[12]_i_2_n_0 ;
  wire \count_usec[12]_i_3_n_0 ;
  wire \count_usec[12]_i_4_n_0 ;
  wire \count_usec[12]_i_5_n_0 ;
  wire \count_usec[16]_i_2_n_0 ;
  wire \count_usec[16]_i_3_n_0 ;
  wire \count_usec[16]_i_4_n_0 ;
  wire \count_usec[16]_i_5_n_0 ;
  wire \count_usec[20]_i_2_n_0 ;
  wire \count_usec[20]_i_3_n_0 ;
  wire \count_usec[4]_i_2_n_0 ;
  wire \count_usec[4]_i_3_n_0 ;
  wire \count_usec[4]_i_4_n_0 ;
  wire \count_usec[4]_i_5_n_0 ;
  wire \count_usec[8]_i_2_n_0 ;
  wire \count_usec[8]_i_3_n_0 ;
  wire \count_usec[8]_i_4_n_0 ;
  wire \count_usec[8]_i_5_n_0 ;
  wire [21:0]count_usec_reg;
  wire \count_usec_reg[0]_i_2_n_0 ;
  wire \count_usec_reg[0]_i_2_n_1 ;
  wire \count_usec_reg[0]_i_2_n_2 ;
  wire \count_usec_reg[0]_i_2_n_3 ;
  wire [3:0]\count_usec_reg[11] ;
  wire \count_usec_reg[12]_i_1_n_0 ;
  wire \count_usec_reg[12]_i_1_n_1 ;
  wire \count_usec_reg[12]_i_1_n_2 ;
  wire \count_usec_reg[12]_i_1_n_3 ;
  wire [3:0]\count_usec_reg[15] ;
  wire \count_usec_reg[16]_i_1_n_0 ;
  wire \count_usec_reg[16]_i_1_n_1 ;
  wire \count_usec_reg[16]_i_1_n_2 ;
  wire \count_usec_reg[16]_i_1_n_3 ;
  wire [3:0]\count_usec_reg[19] ;
  wire \count_usec_reg[20]_i_1_n_3 ;
  wire [1:0]\count_usec_reg[21] ;
  wire \count_usec_reg[4]_i_1_n_0 ;
  wire \count_usec_reg[4]_i_1_n_1 ;
  wire \count_usec_reg[4]_i_1_n_2 ;
  wire \count_usec_reg[4]_i_1_n_3 ;
  wire [3:0]\count_usec_reg[7] ;
  wire \count_usec_reg[8]_i_1_n_0 ;
  wire \count_usec_reg[8]_i_1_n_1 ;
  wire \count_usec_reg[8]_i_1_n_2 ;
  wire \count_usec_reg[8]_i_1_n_3 ;
  wire count_usec_reg_0_sn_1;
  wire ff_old_reg_0;
  wire [1:0]p_0_in;
  wire s00_axi_aclk;
  wire s00_axi_aresetn;
  wire s00_axi_aresetn_0;
  wire [3:1]\NLW_count_usec_reg[20]_i_1_CO_UNCONNECTED ;
  wire [3:2]\NLW_count_usec_reg[20]_i_1_O_UNCONNECTED ;

  assign count_usec_reg_0_sn_1 = count_usec_reg_0_sp_1;
  LUT3 #(
    .INIT(8'h2F)) 
    \count_usec[0]_i_1 
       (.I0(p_0_in[0]),
        .I1(p_0_in[1]),
        .I2(count_usec_reg_0_sn_1),
        .O(ff_old_reg_0));
  LUT3 #(
    .INIT(8'h40)) 
    \count_usec[0]_i_3 
       (.I0(p_0_in[1]),
        .I1(p_0_in[0]),
        .I2(count_usec_reg_0_sn_1),
        .O(count_usec1));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[0]_i_4 
       (.I0(count_usec_reg[3]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[0]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[0]_i_5 
       (.I0(count_usec_reg[2]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[0]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[0]_i_6 
       (.I0(count_usec_reg[1]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[0]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hCC4C)) 
    \count_usec[0]_i_7 
       (.I0(count_usec_reg[0]),
        .I1(count_usec_reg_0_sn_1),
        .I2(p_0_in[0]),
        .I3(p_0_in[1]),
        .O(\count_usec[0]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[12]_i_2 
       (.I0(count_usec_reg[15]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[12]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[12]_i_3 
       (.I0(count_usec_reg[14]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[12]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[12]_i_4 
       (.I0(count_usec_reg[13]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[12]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[12]_i_5 
       (.I0(count_usec_reg[12]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[12]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[16]_i_2 
       (.I0(count_usec_reg[19]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[16]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[16]_i_3 
       (.I0(count_usec_reg[18]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[16]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[16]_i_4 
       (.I0(count_usec_reg[17]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[16]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[16]_i_5 
       (.I0(count_usec_reg[16]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[16]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[20]_i_2 
       (.I0(count_usec_reg[21]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[20]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[20]_i_3 
       (.I0(count_usec_reg[20]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[20]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[4]_i_2 
       (.I0(count_usec_reg[7]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[4]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[4]_i_3 
       (.I0(count_usec_reg[6]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[4]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[4]_i_4 
       (.I0(count_usec_reg[5]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[4]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[4]_i_5 
       (.I0(count_usec_reg[4]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[4]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[8]_i_2 
       (.I0(count_usec_reg[11]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[8]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[8]_i_3 
       (.I0(count_usec_reg[10]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[8]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[8]_i_4 
       (.I0(count_usec_reg[9]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[8]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hEF00)) 
    \count_usec[8]_i_5 
       (.I0(count_usec_reg[8]),
        .I1(p_0_in[1]),
        .I2(p_0_in[0]),
        .I3(count_usec_reg_0_sn_1),
        .O(\count_usec[8]_i_5_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \count_usec_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\count_usec_reg[0]_i_2_n_0 ,\count_usec_reg[0]_i_2_n_1 ,\count_usec_reg[0]_i_2_n_2 ,\count_usec_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,count_usec1}),
        .O(O),
        .S({\count_usec[0]_i_4_n_0 ,\count_usec[0]_i_5_n_0 ,\count_usec[0]_i_6_n_0 ,\count_usec[0]_i_7_n_0 }));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \count_usec_reg[12]_i_1 
       (.CI(\count_usec_reg[8]_i_1_n_0 ),
        .CO({\count_usec_reg[12]_i_1_n_0 ,\count_usec_reg[12]_i_1_n_1 ,\count_usec_reg[12]_i_1_n_2 ,\count_usec_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\count_usec_reg[15] ),
        .S({\count_usec[12]_i_2_n_0 ,\count_usec[12]_i_3_n_0 ,\count_usec[12]_i_4_n_0 ,\count_usec[12]_i_5_n_0 }));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \count_usec_reg[16]_i_1 
       (.CI(\count_usec_reg[12]_i_1_n_0 ),
        .CO({\count_usec_reg[16]_i_1_n_0 ,\count_usec_reg[16]_i_1_n_1 ,\count_usec_reg[16]_i_1_n_2 ,\count_usec_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\count_usec_reg[19] ),
        .S({\count_usec[16]_i_2_n_0 ,\count_usec[16]_i_3_n_0 ,\count_usec[16]_i_4_n_0 ,\count_usec[16]_i_5_n_0 }));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \count_usec_reg[20]_i_1 
       (.CI(\count_usec_reg[16]_i_1_n_0 ),
        .CO({\NLW_count_usec_reg[20]_i_1_CO_UNCONNECTED [3:1],\count_usec_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_count_usec_reg[20]_i_1_O_UNCONNECTED [3:2],\count_usec_reg[21] }),
        .S({1'b0,1'b0,\count_usec[20]_i_2_n_0 ,\count_usec[20]_i_3_n_0 }));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \count_usec_reg[4]_i_1 
       (.CI(\count_usec_reg[0]_i_2_n_0 ),
        .CO({\count_usec_reg[4]_i_1_n_0 ,\count_usec_reg[4]_i_1_n_1 ,\count_usec_reg[4]_i_1_n_2 ,\count_usec_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\count_usec_reg[7] ),
        .S({\count_usec[4]_i_2_n_0 ,\count_usec[4]_i_3_n_0 ,\count_usec[4]_i_4_n_0 ,\count_usec[4]_i_5_n_0 }));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \count_usec_reg[8]_i_1 
       (.CI(\count_usec_reg[4]_i_1_n_0 ),
        .CO({\count_usec_reg[8]_i_1_n_0 ,\count_usec_reg[8]_i_1_n_1 ,\count_usec_reg[8]_i_1_n_2 ,\count_usec_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\count_usec_reg[11] ),
        .S({\count_usec[8]_i_2_n_0 ,\count_usec[8]_i_3_n_0 ,\count_usec[8]_i_4_n_0 ,\count_usec[8]_i_5_n_0 }));
  LUT1 #(
    .INIT(2'h1)) 
    \data_count[5]_i_3 
       (.I0(s00_axi_aresetn),
        .O(s00_axi_aresetn_0));
  FDCE ff_cur_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .CLR(s00_axi_aresetn_0),
        .D(clk_div_100),
        .Q(p_0_in[1]));
  FDCE ff_old_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .CLR(s00_axi_aresetn_0),
        .D(p_0_in[1]),
        .Q(p_0_in[0]));
endmodule

(* ORIG_REF_NAME = "myip_dht11" *) 
module soc_dht11_myip_dht11_0_0_myip_dht11
   (Q,
    led,
    axi_awready_reg,
    axi_arready_reg,
    axi_rvalid_reg,
    s00_axi_rdata,
    s00_axi_bvalid,
    s00_axi_wready,
    dht11_data,
    s00_axi_aclk,
    s00_axi_awvalid,
    s00_axi_wvalid,
    s00_axi_arvalid,
    s00_axi_rready,
    s00_axi_awaddr,
    s00_axi_wdata,
    s00_axi_araddr,
    s00_axi_aresetn,
    s00_axi_wstrb,
    s00_axi_bready);
  output [5:0]Q;
  output [5:0]led;
  output axi_awready_reg;
  output axi_arready_reg;
  output axi_rvalid_reg;
  output [31:0]s00_axi_rdata;
  output s00_axi_bvalid;
  output s00_axi_wready;
  inout dht11_data;
  input s00_axi_aclk;
  input s00_axi_awvalid;
  input s00_axi_wvalid;
  input s00_axi_arvalid;
  input s00_axi_rready;
  input [2:0]s00_axi_awaddr;
  input [31:0]s00_axi_wdata;
  input [2:0]s00_axi_araddr;
  input s00_axi_aresetn;
  input [3:0]s00_axi_wstrb;
  input s00_axi_bready;

  wire [5:0]Q;
  wire axi_arready_i_1_n_0;
  wire axi_arready_reg;
  wire axi_awready0__0;
  wire axi_awready_i_1_n_0;
  wire axi_awready_reg;
  wire axi_bvalid_i_1_n_0;
  wire axi_rvalid_i_1_n_0;
  wire axi_rvalid_reg;
  wire axi_wready_i_1_n_0;
  wire clk_div_100_i_1_n_0;
  wire count_usec_e_i_1_n_0;
  wire \dht11/clk_div_100 ;
  wire \dht11/dht11_data_out_e ;
  wire dht11_data;
  wire dht11_data_out_e_i_1_n_0;
  wire [5:0]led;
  wire myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_1;
  wire myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_2;
  wire myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_57;
  wire myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_58;
  wire myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_59;
  wire myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_60;
  wire myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_61;
  wire myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_62;
  wire myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_64;
  wire s00_axi_aclk;
  wire [2:0]s00_axi_araddr;
  wire s00_axi_aresetn;
  wire s00_axi_arvalid;
  wire [2:0]s00_axi_awaddr;
  wire s00_axi_awvalid;
  wire s00_axi_bready;
  wire s00_axi_bvalid;
  wire [31:0]s00_axi_rdata;
  wire s00_axi_rready;
  wire [31:0]s00_axi_wdata;
  wire s00_axi_wready;
  wire [3:0]s00_axi_wstrb;
  wire s00_axi_wvalid;
  wire [1:0]state_read;
  wire [1:0]state_write;

  LUT6 #(
    .INIT(64'hA2A2A2A2FFAFAFAF)) 
    axi_arready_i_1
       (.I0(axi_arready_reg),
        .I1(s00_axi_arvalid),
        .I2(state_read[1]),
        .I3(axi_rvalid_reg),
        .I4(s00_axi_rready),
        .I5(state_read[0]),
        .O(axi_arready_i_1_n_0));
  LUT5 #(
    .INIT(32'hFDFF4545)) 
    axi_awready_i_1
       (.I0(state_write[0]),
        .I1(s00_axi_wvalid),
        .I2(state_write[1]),
        .I3(s00_axi_awvalid),
        .I4(axi_awready_reg),
        .O(axi_awready_i_1_n_0));
  LUT6 #(
    .INIT(64'hAAF2AA22F2AAF2AA)) 
    axi_bvalid_i_1
       (.I0(s00_axi_bvalid),
        .I1(s00_axi_bready),
        .I2(s00_axi_wvalid),
        .I3(state_write[1]),
        .I4(axi_awready0__0),
        .I5(state_write[0]),
        .O(axi_bvalid_i_1_n_0));
  LUT6 #(
    .INIT(64'hF000FF00FF80FF80)) 
    axi_rvalid_i_1
       (.I0(s00_axi_arvalid),
        .I1(axi_arready_reg),
        .I2(state_read[0]),
        .I3(axi_rvalid_reg),
        .I4(s00_axi_rready),
        .I5(state_read[1]),
        .O(axi_rvalid_i_1_n_0));
  LUT3 #(
    .INIT(8'hF1)) 
    axi_wready_i_1
       (.I0(state_write[1]),
        .I1(state_write[0]),
        .I2(s00_axi_wready),
        .O(axi_wready_i_1_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    clk_div_100_i_1
       (.I0(myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_64),
        .I1(\dht11/clk_div_100 ),
        .O(clk_div_100_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFFF4FF0000F400)) 
    count_usec_e_i_1
       (.I0(myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_59),
        .I1(myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_60),
        .I2(myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_62),
        .I3(s00_axi_aresetn),
        .I4(myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_57),
        .I5(myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_1),
        .O(count_usec_e_i_1_n_0));
  LUT4 #(
    .INIT(16'hFB08)) 
    dht11_data_out_e_i_1
       (.I0(\dht11/dht11_data_out_e ),
        .I1(myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_58),
        .I2(myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_61),
        .I3(myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_2),
        .O(dht11_data_out_e_i_1_n_0));
  soc_dht11_myip_dht11_0_0_myip_dht11_slave_lite_v1_0_S00_AXI myip_dht11_slave_lite_v1_0_S00_AXI_inst
       (.Q(Q),
        .axi_arready_reg_0(axi_arready_reg),
        .axi_arready_reg_1(axi_arready_i_1_n_0),
        .axi_awready0__0(axi_awready0__0),
        .axi_awready_reg_0(axi_awready_reg),
        .axi_awready_reg_1(axi_awready_i_1_n_0),
        .axi_bvalid_reg_0(axi_bvalid_i_1_n_0),
        .axi_rvalid_reg_0(axi_rvalid_reg),
        .axi_rvalid_reg_1(axi_rvalid_i_1_n_0),
        .axi_wready_reg_0(axi_wready_i_1_n_0),
        .clk_div_100(\dht11/clk_div_100 ),
        .clk_div_100_reg(clk_div_100_i_1_n_0),
        .\cnt_sysclk_reg[5] (myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_64),
        .count_usec_e_reg(myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_1),
        .count_usec_e_reg_0(count_usec_e_i_1_n_0),
        .\count_usec_reg[14] (myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_59),
        .dht11_data(dht11_data),
        .dht11_data_out_e(\dht11/dht11_data_out_e ),
        .dht11_data_out_e_reg(myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_2),
        .dht11_data_out_e_reg_0(dht11_data_out_e_i_1_n_0),
        .s00_axi_aclk(s00_axi_aclk),
        .s00_axi_araddr(s00_axi_araddr),
        .s00_axi_aresetn(s00_axi_aresetn),
        .s00_axi_arvalid(s00_axi_arvalid),
        .s00_axi_awaddr(s00_axi_awaddr),
        .s00_axi_awvalid(s00_axi_awvalid),
        .s00_axi_bvalid(s00_axi_bvalid),
        .s00_axi_rdata(s00_axi_rdata),
        .s00_axi_rready(s00_axi_rready),
        .s00_axi_wdata(s00_axi_wdata),
        .s00_axi_wready(s00_axi_wready),
        .s00_axi_wstrb(s00_axi_wstrb),
        .s00_axi_wvalid(s00_axi_wvalid),
        .state_read(state_read),
        .\state_reg[0] (myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_61),
        .\state_reg[0]_0 (myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_62),
        .\state_reg[1] (myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_57),
        .\state_reg[3] (myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_60),
        .\state_reg[5] (led),
        .\state_reg[5]_0 (myip_dht11_slave_lite_v1_0_S00_AXI_inst_n_58),
        .state_write(state_write));
endmodule

(* ORIG_REF_NAME = "myip_dht11_slave_lite_v1_0_S00_AXI" *) 
module soc_dht11_myip_dht11_0_0_myip_dht11_slave_lite_v1_0_S00_AXI
   (clk_div_100,
    count_usec_e_reg,
    dht11_data_out_e_reg,
    s00_axi_bvalid,
    axi_awready_reg_0,
    s00_axi_wready,
    axi_rvalid_reg_0,
    axi_arready_reg_0,
    Q,
    \state_reg[5] ,
    state_write,
    state_read,
    s00_axi_rdata,
    axi_awready0__0,
    \state_reg[1] ,
    \state_reg[5]_0 ,
    \count_usec_reg[14] ,
    \state_reg[3] ,
    \state_reg[0] ,
    \state_reg[0]_0 ,
    dht11_data_out_e,
    \cnt_sysclk_reg[5] ,
    dht11_data,
    s00_axi_aclk,
    clk_div_100_reg,
    count_usec_e_reg_0,
    dht11_data_out_e_reg_0,
    axi_bvalid_reg_0,
    axi_awready_reg_1,
    axi_wready_reg_0,
    axi_rvalid_reg_1,
    axi_arready_reg_1,
    s00_axi_awvalid,
    s00_axi_wvalid,
    s00_axi_arvalid,
    s00_axi_rready,
    s00_axi_awaddr,
    s00_axi_wdata,
    s00_axi_araddr,
    s00_axi_aresetn,
    s00_axi_wstrb);
  output clk_div_100;
  output count_usec_e_reg;
  output dht11_data_out_e_reg;
  output s00_axi_bvalid;
  output axi_awready_reg_0;
  output s00_axi_wready;
  output axi_rvalid_reg_0;
  output axi_arready_reg_0;
  output [5:0]Q;
  output [5:0]\state_reg[5] ;
  output [1:0]state_write;
  output [1:0]state_read;
  output [31:0]s00_axi_rdata;
  output axi_awready0__0;
  output \state_reg[1] ;
  output \state_reg[5]_0 ;
  output \count_usec_reg[14] ;
  output \state_reg[3] ;
  output \state_reg[0] ;
  output \state_reg[0]_0 ;
  output dht11_data_out_e;
  output \cnt_sysclk_reg[5] ;
  inout dht11_data;
  input s00_axi_aclk;
  input clk_div_100_reg;
  input count_usec_e_reg_0;
  input dht11_data_out_e_reg_0;
  input axi_bvalid_reg_0;
  input axi_awready_reg_1;
  input axi_wready_reg_0;
  input axi_rvalid_reg_1;
  input axi_arready_reg_1;
  input s00_axi_awvalid;
  input s00_axi_wvalid;
  input s00_axi_arvalid;
  input s00_axi_rready;
  input [2:0]s00_axi_awaddr;
  input [31:0]s00_axi_wdata;
  input [2:0]s00_axi_araddr;
  input s00_axi_aresetn;
  input [3:0]s00_axi_wstrb;

  wire \FSM_sequential_state_read[0]_i_1_n_0 ;
  wire \FSM_sequential_state_read[1]_i_1_n_0 ;
  wire \FSM_sequential_state_write[0]_i_1_n_0 ;
  wire \FSM_sequential_state_write[1]_i_1_n_0 ;
  wire [5:0]Q;
  wire \axi_araddr[2]_i_1_n_0 ;
  wire \axi_araddr[3]_i_1_n_0 ;
  wire \axi_araddr[4]_i_1_n_0 ;
  wire \axi_araddr[4]_i_2_n_0 ;
  wire axi_arready_reg_0;
  wire axi_arready_reg_1;
  wire \axi_awaddr[2]_i_1_n_0 ;
  wire \axi_awaddr[3]_i_1_n_0 ;
  wire \axi_awaddr[4]_i_1_n_0 ;
  wire \axi_awaddr_reg_n_0_[2] ;
  wire \axi_awaddr_reg_n_0_[3] ;
  wire \axi_awaddr_reg_n_0_[4] ;
  wire axi_awready0__0;
  wire axi_awready_reg_0;
  wire axi_awready_reg_1;
  wire axi_bvalid_reg_0;
  wire axi_rvalid_reg_0;
  wire axi_rvalid_reg_1;
  wire axi_wready_reg_0;
  wire clk_div_100;
  wire clk_div_100_reg;
  wire \cnt_sysclk_reg[5] ;
  wire count_usec_e_reg;
  wire count_usec_e_reg_0;
  wire \count_usec_reg[14] ;
  wire dht11_data;
  wire dht11_data_out_e;
  wire dht11_data_out_e_reg;
  wire dht11_data_out_e_reg_0;
  wire dht11_n_1;
  wire [7:0]humidity;
  wire [31:7]p_1_in;
  wire s00_axi_aclk;
  wire [2:0]s00_axi_araddr;
  wire s00_axi_aresetn;
  wire s00_axi_arvalid;
  wire [2:0]s00_axi_awaddr;
  wire s00_axi_awvalid;
  wire s00_axi_bvalid;
  wire [31:0]s00_axi_rdata;
  wire \s00_axi_rdata[0]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[0]_INST_0_i_2_n_0 ;
  wire \s00_axi_rdata[10]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[11]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[12]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[13]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[14]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[15]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[16]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[17]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[18]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[19]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[1]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[1]_INST_0_i_2_n_0 ;
  wire \s00_axi_rdata[20]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[21]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[22]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[23]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[24]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[25]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[26]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[27]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[28]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[29]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[2]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[2]_INST_0_i_2_n_0 ;
  wire \s00_axi_rdata[30]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[31]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[3]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[3]_INST_0_i_2_n_0 ;
  wire \s00_axi_rdata[4]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[4]_INST_0_i_2_n_0 ;
  wire \s00_axi_rdata[5]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[5]_INST_0_i_2_n_0 ;
  wire \s00_axi_rdata[6]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[6]_INST_0_i_2_n_0 ;
  wire \s00_axi_rdata[7]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[7]_INST_0_i_2_n_0 ;
  wire \s00_axi_rdata[8]_INST_0_i_1_n_0 ;
  wire \s00_axi_rdata[9]_INST_0_i_1_n_0 ;
  wire s00_axi_rready;
  wire [31:0]s00_axi_wdata;
  wire s00_axi_wready;
  wire [3:0]s00_axi_wstrb;
  wire s00_axi_wvalid;
  wire [2:0]sel0;
  wire [31:0]slv_reg2;
  wire \slv_reg2[31]_i_2_n_0 ;
  wire \slv_reg2[31]_i_3_n_0 ;
  wire \slv_reg2[31]_i_4_n_0 ;
  wire [31:0]slv_reg3;
  wire \slv_reg3[15]_i_1_n_0 ;
  wire \slv_reg3[23]_i_1_n_0 ;
  wire \slv_reg3[31]_i_1_n_0 ;
  wire \slv_reg3[31]_i_2_n_0 ;
  wire \slv_reg3[7]_i_1_n_0 ;
  wire [31:0]slv_reg4;
  wire \slv_reg4[15]_i_1_n_0 ;
  wire \slv_reg4[23]_i_1_n_0 ;
  wire \slv_reg4[31]_i_1_n_0 ;
  wire \slv_reg4[31]_i_2_n_0 ;
  wire \slv_reg4[7]_i_1_n_0 ;
  wire [31:0]slv_reg5;
  wire \slv_reg5[15]_i_1_n_0 ;
  wire \slv_reg5[23]_i_1_n_0 ;
  wire \slv_reg5[31]_i_1_n_0 ;
  wire \slv_reg5[31]_i_2_n_0 ;
  wire \slv_reg5[7]_i_1_n_0 ;
  wire [31:0]slv_reg6;
  wire \slv_reg6[15]_i_1_n_0 ;
  wire \slv_reg6[23]_i_1_n_0 ;
  wire \slv_reg6[31]_i_1_n_0 ;
  wire \slv_reg6[31]_i_2_n_0 ;
  wire \slv_reg6[7]_i_1_n_0 ;
  wire [31:0]slv_reg7;
  wire \slv_reg7[15]_i_1_n_0 ;
  wire \slv_reg7[23]_i_1_n_0 ;
  wire \slv_reg7[31]_i_1_n_0 ;
  wire \slv_reg7[31]_i_2_n_0 ;
  wire \slv_reg7[7]_i_1_n_0 ;
  wire [1:0]state_read;
  wire \state_reg[0] ;
  wire \state_reg[0]_0 ;
  wire \state_reg[1] ;
  wire \state_reg[3] ;
  wire [5:0]\state_reg[5] ;
  wire \state_reg[5]_0 ;
  wire [1:0]state_write;
  wire [7:0]temperature;

  LUT6 #(
    .INIT(64'hFFFF0FFF8888FFFF)) 
    \FSM_sequential_state_read[0]_i_1 
       (.I0(axi_rvalid_reg_0),
        .I1(s00_axi_rready),
        .I2(axi_arready_reg_0),
        .I3(s00_axi_arvalid),
        .I4(state_read[1]),
        .I5(state_read[0]),
        .O(\FSM_sequential_state_read[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF88880FFF0000)) 
    \FSM_sequential_state_read[1]_i_1 
       (.I0(s00_axi_arvalid),
        .I1(axi_arready_reg_0),
        .I2(axi_rvalid_reg_0),
        .I3(s00_axi_rready),
        .I4(state_read[1]),
        .I5(state_read[0]),
        .O(\FSM_sequential_state_read[1]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "Idle:00,Rdata:10,Raddr:01" *) 
  FDRE \FSM_sequential_state_read_reg[0] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\FSM_sequential_state_read[0]_i_1_n_0 ),
        .Q(state_read[0]),
        .R(dht11_n_1));
  (* FSM_ENCODED_STATES = "Idle:00,Rdata:10,Raddr:01" *) 
  FDRE \FSM_sequential_state_read_reg[1] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\FSM_sequential_state_read[1]_i_1_n_0 ),
        .Q(state_read[1]),
        .R(dht11_n_1));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'hFFF0F7FF)) 
    \FSM_sequential_state_write[0]_i_1 
       (.I0(s00_axi_awvalid),
        .I1(axi_awready_reg_0),
        .I2(s00_axi_wvalid),
        .I3(state_write[0]),
        .I4(state_write[1]),
        .O(\FSM_sequential_state_write[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'hFF0F0800)) 
    \FSM_sequential_state_write[1]_i_1 
       (.I0(axi_awready_reg_0),
        .I1(s00_axi_awvalid),
        .I2(s00_axi_wvalid),
        .I3(state_write[0]),
        .I4(state_write[1]),
        .O(\FSM_sequential_state_write[1]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "Idle:00,Wdata:10,Waddr:01" *) 
  FDRE \FSM_sequential_state_write_reg[0] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\FSM_sequential_state_write[0]_i_1_n_0 ),
        .Q(state_write[0]),
        .R(dht11_n_1));
  (* FSM_ENCODED_STATES = "Idle:00,Wdata:10,Waddr:01" *) 
  FDRE \FSM_sequential_state_write_reg[1] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\FSM_sequential_state_write[1]_i_1_n_0 ),
        .Q(state_write[1]),
        .R(dht11_n_1));
  LUT5 #(
    .INIT(32'hBFFF8000)) 
    \axi_araddr[2]_i_1 
       (.I0(s00_axi_araddr[0]),
        .I1(\axi_araddr[4]_i_2_n_0 ),
        .I2(state_read[0]),
        .I3(s00_axi_aresetn),
        .I4(sel0[0]),
        .O(\axi_araddr[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hBFFF8000)) 
    \axi_araddr[3]_i_1 
       (.I0(s00_axi_araddr[1]),
        .I1(\axi_araddr[4]_i_2_n_0 ),
        .I2(state_read[0]),
        .I3(s00_axi_aresetn),
        .I4(sel0[1]),
        .O(\axi_araddr[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hBFFF8000)) 
    \axi_araddr[4]_i_1 
       (.I0(s00_axi_araddr[2]),
        .I1(\axi_araddr[4]_i_2_n_0 ),
        .I2(state_read[0]),
        .I3(s00_axi_aresetn),
        .I4(sel0[2]),
        .O(\axi_araddr[4]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h08)) 
    \axi_araddr[4]_i_2 
       (.I0(s00_axi_arvalid),
        .I1(axi_arready_reg_0),
        .I2(state_read[1]),
        .O(\axi_araddr[4]_i_2_n_0 ));
  FDRE \axi_araddr_reg[2] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_araddr[2]_i_1_n_0 ),
        .Q(sel0[0]),
        .R(1'b0));
  FDRE \axi_araddr_reg[3] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_araddr[3]_i_1_n_0 ),
        .Q(sel0[1]),
        .R(1'b0));
  FDRE \axi_araddr_reg[4] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_araddr[4]_i_1_n_0 ),
        .Q(sel0[2]),
        .R(1'b0));
  FDRE axi_arready_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_arready_reg_1),
        .Q(axi_arready_reg_0),
        .R(dht11_n_1));
  LUT6 #(
    .INIT(64'hEFFFFFFF20000000)) 
    \axi_awaddr[2]_i_1 
       (.I0(s00_axi_awaddr[0]),
        .I1(state_write[1]),
        .I2(s00_axi_awvalid),
        .I3(axi_awready_reg_0),
        .I4(state_write[0]),
        .I5(\axi_awaddr_reg_n_0_[2] ),
        .O(\axi_awaddr[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hEFFFFFFF20000000)) 
    \axi_awaddr[3]_i_1 
       (.I0(s00_axi_awaddr[1]),
        .I1(state_write[1]),
        .I2(s00_axi_awvalid),
        .I3(axi_awready_reg_0),
        .I4(state_write[0]),
        .I5(\axi_awaddr_reg_n_0_[3] ),
        .O(\axi_awaddr[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hEFFFFFFF20000000)) 
    \axi_awaddr[4]_i_1 
       (.I0(s00_axi_awaddr[2]),
        .I1(state_write[1]),
        .I2(s00_axi_awvalid),
        .I3(axi_awready_reg_0),
        .I4(state_write[0]),
        .I5(\axi_awaddr_reg_n_0_[4] ),
        .O(\axi_awaddr[4]_i_1_n_0 ));
  FDRE \axi_awaddr_reg[2] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_awaddr[2]_i_1_n_0 ),
        .Q(\axi_awaddr_reg_n_0_[2] ),
        .R(dht11_n_1));
  FDRE \axi_awaddr_reg[3] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_awaddr[3]_i_1_n_0 ),
        .Q(\axi_awaddr_reg_n_0_[3] ),
        .R(dht11_n_1));
  FDRE \axi_awaddr_reg[4] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_awaddr[4]_i_1_n_0 ),
        .Q(\axi_awaddr_reg_n_0_[4] ),
        .R(dht11_n_1));
  FDRE axi_awready_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_awready_reg_1),
        .Q(axi_awready_reg_0),
        .R(dht11_n_1));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h8)) 
    axi_bvalid_i_2
       (.I0(s00_axi_awvalid),
        .I1(axi_awready_reg_0),
        .O(axi_awready0__0));
  FDRE axi_bvalid_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_bvalid_reg_0),
        .Q(s00_axi_bvalid),
        .R(dht11_n_1));
  FDRE axi_rvalid_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_rvalid_reg_1),
        .Q(axi_rvalid_reg_0),
        .R(dht11_n_1));
  FDRE axi_wready_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_wready_reg_0),
        .Q(s00_axi_wready),
        .R(dht11_n_1));
  soc_dht11_myip_dht11_0_0_dht11_cntr dht11
       (.Q(Q),
        .SR(dht11_n_1),
        .clk_div_100(clk_div_100),
        .clk_div_100_reg(clk_div_100_reg),
        .\cnt_sysclk_reg[5] (\cnt_sysclk_reg[5] ),
        .count_usec_e_reg_0(count_usec_e_reg),
        .count_usec_e_reg_1(count_usec_e_reg_0),
        .\count_usec_reg[14]_0 (\count_usec_reg[14] ),
        .dht11_data(dht11_data),
        .dht11_data_out_e(dht11_data_out_e),
        .dht11_data_out_e_reg_0(dht11_data_out_e_reg),
        .dht11_data_out_e_reg_1(dht11_data_out_e_reg_0),
        .\humidity_reg[7]_0 (humidity),
        .s00_axi_aclk(s00_axi_aclk),
        .s00_axi_aresetn(s00_axi_aresetn),
        .\state_reg[0]_0 (\state_reg[0] ),
        .\state_reg[0]_1 (\state_reg[0]_0 ),
        .\state_reg[1]_0 (\state_reg[1] ),
        .\state_reg[3]_0 (\state_reg[3] ),
        .\state_reg[5]_0 (\state_reg[5] ),
        .\state_reg[5]_1 (\state_reg[5]_0 ),
        .\temperature_reg[7]_0 (temperature));
  MUXF7 \s00_axi_rdata[0]_INST_0 
       (.I0(\s00_axi_rdata[0]_INST_0_i_1_n_0 ),
        .I1(\s00_axi_rdata[0]_INST_0_i_2_n_0 ),
        .O(s00_axi_rdata[0]),
        .S(sel0[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[0]_INST_0_i_1 
       (.I0(slv_reg3[0]),
        .I1(slv_reg2[0]),
        .I2(sel0[1]),
        .I3(temperature[0]),
        .I4(sel0[0]),
        .I5(humidity[0]),
        .O(\s00_axi_rdata[0]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[0]_INST_0_i_2 
       (.I0(slv_reg7[0]),
        .I1(slv_reg6[0]),
        .I2(sel0[1]),
        .I3(slv_reg5[0]),
        .I4(sel0[0]),
        .I5(slv_reg4[0]),
        .O(\s00_axi_rdata[0]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[10]_INST_0 
       (.I0(\s00_axi_rdata[10]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[10]),
        .I4(sel0[0]),
        .I5(slv_reg3[10]),
        .O(s00_axi_rdata[10]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[10]_INST_0_i_1 
       (.I0(slv_reg7[10]),
        .I1(slv_reg6[10]),
        .I2(sel0[1]),
        .I3(slv_reg5[10]),
        .I4(sel0[0]),
        .I5(slv_reg4[10]),
        .O(\s00_axi_rdata[10]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[11]_INST_0 
       (.I0(\s00_axi_rdata[11]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[11]),
        .I4(sel0[0]),
        .I5(slv_reg3[11]),
        .O(s00_axi_rdata[11]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[11]_INST_0_i_1 
       (.I0(slv_reg7[11]),
        .I1(slv_reg6[11]),
        .I2(sel0[1]),
        .I3(slv_reg5[11]),
        .I4(sel0[0]),
        .I5(slv_reg4[11]),
        .O(\s00_axi_rdata[11]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[12]_INST_0 
       (.I0(\s00_axi_rdata[12]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[12]),
        .I4(sel0[0]),
        .I5(slv_reg3[12]),
        .O(s00_axi_rdata[12]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[12]_INST_0_i_1 
       (.I0(slv_reg7[12]),
        .I1(slv_reg6[12]),
        .I2(sel0[1]),
        .I3(slv_reg5[12]),
        .I4(sel0[0]),
        .I5(slv_reg4[12]),
        .O(\s00_axi_rdata[12]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[13]_INST_0 
       (.I0(\s00_axi_rdata[13]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[13]),
        .I4(sel0[0]),
        .I5(slv_reg3[13]),
        .O(s00_axi_rdata[13]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[13]_INST_0_i_1 
       (.I0(slv_reg7[13]),
        .I1(slv_reg6[13]),
        .I2(sel0[1]),
        .I3(slv_reg5[13]),
        .I4(sel0[0]),
        .I5(slv_reg4[13]),
        .O(\s00_axi_rdata[13]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[14]_INST_0 
       (.I0(\s00_axi_rdata[14]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[14]),
        .I4(sel0[0]),
        .I5(slv_reg3[14]),
        .O(s00_axi_rdata[14]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[14]_INST_0_i_1 
       (.I0(slv_reg7[14]),
        .I1(slv_reg6[14]),
        .I2(sel0[1]),
        .I3(slv_reg5[14]),
        .I4(sel0[0]),
        .I5(slv_reg4[14]),
        .O(\s00_axi_rdata[14]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[15]_INST_0 
       (.I0(\s00_axi_rdata[15]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[15]),
        .I4(sel0[0]),
        .I5(slv_reg3[15]),
        .O(s00_axi_rdata[15]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[15]_INST_0_i_1 
       (.I0(slv_reg7[15]),
        .I1(slv_reg6[15]),
        .I2(sel0[1]),
        .I3(slv_reg5[15]),
        .I4(sel0[0]),
        .I5(slv_reg4[15]),
        .O(\s00_axi_rdata[15]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[16]_INST_0 
       (.I0(\s00_axi_rdata[16]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[16]),
        .I4(sel0[0]),
        .I5(slv_reg3[16]),
        .O(s00_axi_rdata[16]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[16]_INST_0_i_1 
       (.I0(slv_reg7[16]),
        .I1(slv_reg6[16]),
        .I2(sel0[1]),
        .I3(slv_reg5[16]),
        .I4(sel0[0]),
        .I5(slv_reg4[16]),
        .O(\s00_axi_rdata[16]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[17]_INST_0 
       (.I0(\s00_axi_rdata[17]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[17]),
        .I4(sel0[0]),
        .I5(slv_reg3[17]),
        .O(s00_axi_rdata[17]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[17]_INST_0_i_1 
       (.I0(slv_reg7[17]),
        .I1(slv_reg6[17]),
        .I2(sel0[1]),
        .I3(slv_reg5[17]),
        .I4(sel0[0]),
        .I5(slv_reg4[17]),
        .O(\s00_axi_rdata[17]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[18]_INST_0 
       (.I0(\s00_axi_rdata[18]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[18]),
        .I4(sel0[0]),
        .I5(slv_reg3[18]),
        .O(s00_axi_rdata[18]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[18]_INST_0_i_1 
       (.I0(slv_reg7[18]),
        .I1(slv_reg6[18]),
        .I2(sel0[1]),
        .I3(slv_reg5[18]),
        .I4(sel0[0]),
        .I5(slv_reg4[18]),
        .O(\s00_axi_rdata[18]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[19]_INST_0 
       (.I0(\s00_axi_rdata[19]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[19]),
        .I4(sel0[0]),
        .I5(slv_reg3[19]),
        .O(s00_axi_rdata[19]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[19]_INST_0_i_1 
       (.I0(slv_reg7[19]),
        .I1(slv_reg6[19]),
        .I2(sel0[1]),
        .I3(slv_reg5[19]),
        .I4(sel0[0]),
        .I5(slv_reg4[19]),
        .O(\s00_axi_rdata[19]_INST_0_i_1_n_0 ));
  MUXF7 \s00_axi_rdata[1]_INST_0 
       (.I0(\s00_axi_rdata[1]_INST_0_i_1_n_0 ),
        .I1(\s00_axi_rdata[1]_INST_0_i_2_n_0 ),
        .O(s00_axi_rdata[1]),
        .S(sel0[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[1]_INST_0_i_1 
       (.I0(slv_reg3[1]),
        .I1(slv_reg2[1]),
        .I2(sel0[1]),
        .I3(temperature[1]),
        .I4(sel0[0]),
        .I5(humidity[1]),
        .O(\s00_axi_rdata[1]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[1]_INST_0_i_2 
       (.I0(slv_reg7[1]),
        .I1(slv_reg6[1]),
        .I2(sel0[1]),
        .I3(slv_reg5[1]),
        .I4(sel0[0]),
        .I5(slv_reg4[1]),
        .O(\s00_axi_rdata[1]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[20]_INST_0 
       (.I0(\s00_axi_rdata[20]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[20]),
        .I4(sel0[0]),
        .I5(slv_reg3[20]),
        .O(s00_axi_rdata[20]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[20]_INST_0_i_1 
       (.I0(slv_reg7[20]),
        .I1(slv_reg6[20]),
        .I2(sel0[1]),
        .I3(slv_reg5[20]),
        .I4(sel0[0]),
        .I5(slv_reg4[20]),
        .O(\s00_axi_rdata[20]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[21]_INST_0 
       (.I0(\s00_axi_rdata[21]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[21]),
        .I4(sel0[0]),
        .I5(slv_reg3[21]),
        .O(s00_axi_rdata[21]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[21]_INST_0_i_1 
       (.I0(slv_reg7[21]),
        .I1(slv_reg6[21]),
        .I2(sel0[1]),
        .I3(slv_reg5[21]),
        .I4(sel0[0]),
        .I5(slv_reg4[21]),
        .O(\s00_axi_rdata[21]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[22]_INST_0 
       (.I0(\s00_axi_rdata[22]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[22]),
        .I4(sel0[0]),
        .I5(slv_reg3[22]),
        .O(s00_axi_rdata[22]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[22]_INST_0_i_1 
       (.I0(slv_reg7[22]),
        .I1(slv_reg6[22]),
        .I2(sel0[1]),
        .I3(slv_reg5[22]),
        .I4(sel0[0]),
        .I5(slv_reg4[22]),
        .O(\s00_axi_rdata[22]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[23]_INST_0 
       (.I0(\s00_axi_rdata[23]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[23]),
        .I4(sel0[0]),
        .I5(slv_reg3[23]),
        .O(s00_axi_rdata[23]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[23]_INST_0_i_1 
       (.I0(slv_reg7[23]),
        .I1(slv_reg6[23]),
        .I2(sel0[1]),
        .I3(slv_reg5[23]),
        .I4(sel0[0]),
        .I5(slv_reg4[23]),
        .O(\s00_axi_rdata[23]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[24]_INST_0 
       (.I0(\s00_axi_rdata[24]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[24]),
        .I4(sel0[0]),
        .I5(slv_reg3[24]),
        .O(s00_axi_rdata[24]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[24]_INST_0_i_1 
       (.I0(slv_reg7[24]),
        .I1(slv_reg6[24]),
        .I2(sel0[1]),
        .I3(slv_reg5[24]),
        .I4(sel0[0]),
        .I5(slv_reg4[24]),
        .O(\s00_axi_rdata[24]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[25]_INST_0 
       (.I0(\s00_axi_rdata[25]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[25]),
        .I4(sel0[0]),
        .I5(slv_reg3[25]),
        .O(s00_axi_rdata[25]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[25]_INST_0_i_1 
       (.I0(slv_reg7[25]),
        .I1(slv_reg6[25]),
        .I2(sel0[1]),
        .I3(slv_reg5[25]),
        .I4(sel0[0]),
        .I5(slv_reg4[25]),
        .O(\s00_axi_rdata[25]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[26]_INST_0 
       (.I0(\s00_axi_rdata[26]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[26]),
        .I4(sel0[0]),
        .I5(slv_reg3[26]),
        .O(s00_axi_rdata[26]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[26]_INST_0_i_1 
       (.I0(slv_reg7[26]),
        .I1(slv_reg6[26]),
        .I2(sel0[1]),
        .I3(slv_reg5[26]),
        .I4(sel0[0]),
        .I5(slv_reg4[26]),
        .O(\s00_axi_rdata[26]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[27]_INST_0 
       (.I0(\s00_axi_rdata[27]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[27]),
        .I4(sel0[0]),
        .I5(slv_reg3[27]),
        .O(s00_axi_rdata[27]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[27]_INST_0_i_1 
       (.I0(slv_reg7[27]),
        .I1(slv_reg6[27]),
        .I2(sel0[1]),
        .I3(slv_reg5[27]),
        .I4(sel0[0]),
        .I5(slv_reg4[27]),
        .O(\s00_axi_rdata[27]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[28]_INST_0 
       (.I0(\s00_axi_rdata[28]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[28]),
        .I4(sel0[0]),
        .I5(slv_reg3[28]),
        .O(s00_axi_rdata[28]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[28]_INST_0_i_1 
       (.I0(slv_reg7[28]),
        .I1(slv_reg6[28]),
        .I2(sel0[1]),
        .I3(slv_reg5[28]),
        .I4(sel0[0]),
        .I5(slv_reg4[28]),
        .O(\s00_axi_rdata[28]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[29]_INST_0 
       (.I0(\s00_axi_rdata[29]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[29]),
        .I4(sel0[0]),
        .I5(slv_reg3[29]),
        .O(s00_axi_rdata[29]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[29]_INST_0_i_1 
       (.I0(slv_reg7[29]),
        .I1(slv_reg6[29]),
        .I2(sel0[1]),
        .I3(slv_reg5[29]),
        .I4(sel0[0]),
        .I5(slv_reg4[29]),
        .O(\s00_axi_rdata[29]_INST_0_i_1_n_0 ));
  MUXF7 \s00_axi_rdata[2]_INST_0 
       (.I0(\s00_axi_rdata[2]_INST_0_i_1_n_0 ),
        .I1(\s00_axi_rdata[2]_INST_0_i_2_n_0 ),
        .O(s00_axi_rdata[2]),
        .S(sel0[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[2]_INST_0_i_1 
       (.I0(slv_reg3[2]),
        .I1(slv_reg2[2]),
        .I2(sel0[1]),
        .I3(temperature[2]),
        .I4(sel0[0]),
        .I5(humidity[2]),
        .O(\s00_axi_rdata[2]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[2]_INST_0_i_2 
       (.I0(slv_reg7[2]),
        .I1(slv_reg6[2]),
        .I2(sel0[1]),
        .I3(slv_reg5[2]),
        .I4(sel0[0]),
        .I5(slv_reg4[2]),
        .O(\s00_axi_rdata[2]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[30]_INST_0 
       (.I0(\s00_axi_rdata[30]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[30]),
        .I4(sel0[0]),
        .I5(slv_reg3[30]),
        .O(s00_axi_rdata[30]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[30]_INST_0_i_1 
       (.I0(slv_reg7[30]),
        .I1(slv_reg6[30]),
        .I2(sel0[1]),
        .I3(slv_reg5[30]),
        .I4(sel0[0]),
        .I5(slv_reg4[30]),
        .O(\s00_axi_rdata[30]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[31]_INST_0 
       (.I0(\s00_axi_rdata[31]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[31]),
        .I4(sel0[0]),
        .I5(slv_reg3[31]),
        .O(s00_axi_rdata[31]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[31]_INST_0_i_1 
       (.I0(slv_reg7[31]),
        .I1(slv_reg6[31]),
        .I2(sel0[1]),
        .I3(slv_reg5[31]),
        .I4(sel0[0]),
        .I5(slv_reg4[31]),
        .O(\s00_axi_rdata[31]_INST_0_i_1_n_0 ));
  MUXF7 \s00_axi_rdata[3]_INST_0 
       (.I0(\s00_axi_rdata[3]_INST_0_i_1_n_0 ),
        .I1(\s00_axi_rdata[3]_INST_0_i_2_n_0 ),
        .O(s00_axi_rdata[3]),
        .S(sel0[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[3]_INST_0_i_1 
       (.I0(slv_reg3[3]),
        .I1(slv_reg2[3]),
        .I2(sel0[1]),
        .I3(temperature[3]),
        .I4(sel0[0]),
        .I5(humidity[3]),
        .O(\s00_axi_rdata[3]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[3]_INST_0_i_2 
       (.I0(slv_reg7[3]),
        .I1(slv_reg6[3]),
        .I2(sel0[1]),
        .I3(slv_reg5[3]),
        .I4(sel0[0]),
        .I5(slv_reg4[3]),
        .O(\s00_axi_rdata[3]_INST_0_i_2_n_0 ));
  MUXF7 \s00_axi_rdata[4]_INST_0 
       (.I0(\s00_axi_rdata[4]_INST_0_i_1_n_0 ),
        .I1(\s00_axi_rdata[4]_INST_0_i_2_n_0 ),
        .O(s00_axi_rdata[4]),
        .S(sel0[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[4]_INST_0_i_1 
       (.I0(slv_reg3[4]),
        .I1(slv_reg2[4]),
        .I2(sel0[1]),
        .I3(temperature[4]),
        .I4(sel0[0]),
        .I5(humidity[4]),
        .O(\s00_axi_rdata[4]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[4]_INST_0_i_2 
       (.I0(slv_reg7[4]),
        .I1(slv_reg6[4]),
        .I2(sel0[1]),
        .I3(slv_reg5[4]),
        .I4(sel0[0]),
        .I5(slv_reg4[4]),
        .O(\s00_axi_rdata[4]_INST_0_i_2_n_0 ));
  MUXF7 \s00_axi_rdata[5]_INST_0 
       (.I0(\s00_axi_rdata[5]_INST_0_i_1_n_0 ),
        .I1(\s00_axi_rdata[5]_INST_0_i_2_n_0 ),
        .O(s00_axi_rdata[5]),
        .S(sel0[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[5]_INST_0_i_1 
       (.I0(slv_reg3[5]),
        .I1(slv_reg2[5]),
        .I2(sel0[1]),
        .I3(temperature[5]),
        .I4(sel0[0]),
        .I5(humidity[5]),
        .O(\s00_axi_rdata[5]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[5]_INST_0_i_2 
       (.I0(slv_reg7[5]),
        .I1(slv_reg6[5]),
        .I2(sel0[1]),
        .I3(slv_reg5[5]),
        .I4(sel0[0]),
        .I5(slv_reg4[5]),
        .O(\s00_axi_rdata[5]_INST_0_i_2_n_0 ));
  MUXF7 \s00_axi_rdata[6]_INST_0 
       (.I0(\s00_axi_rdata[6]_INST_0_i_1_n_0 ),
        .I1(\s00_axi_rdata[6]_INST_0_i_2_n_0 ),
        .O(s00_axi_rdata[6]),
        .S(sel0[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[6]_INST_0_i_1 
       (.I0(slv_reg3[6]),
        .I1(slv_reg2[6]),
        .I2(sel0[1]),
        .I3(temperature[6]),
        .I4(sel0[0]),
        .I5(humidity[6]),
        .O(\s00_axi_rdata[6]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[6]_INST_0_i_2 
       (.I0(slv_reg7[6]),
        .I1(slv_reg6[6]),
        .I2(sel0[1]),
        .I3(slv_reg5[6]),
        .I4(sel0[0]),
        .I5(slv_reg4[6]),
        .O(\s00_axi_rdata[6]_INST_0_i_2_n_0 ));
  MUXF7 \s00_axi_rdata[7]_INST_0 
       (.I0(\s00_axi_rdata[7]_INST_0_i_1_n_0 ),
        .I1(\s00_axi_rdata[7]_INST_0_i_2_n_0 ),
        .O(s00_axi_rdata[7]),
        .S(sel0[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[7]_INST_0_i_1 
       (.I0(slv_reg3[7]),
        .I1(slv_reg2[7]),
        .I2(sel0[1]),
        .I3(temperature[7]),
        .I4(sel0[0]),
        .I5(humidity[7]),
        .O(\s00_axi_rdata[7]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[7]_INST_0_i_2 
       (.I0(slv_reg7[7]),
        .I1(slv_reg6[7]),
        .I2(sel0[1]),
        .I3(slv_reg5[7]),
        .I4(sel0[0]),
        .I5(slv_reg4[7]),
        .O(\s00_axi_rdata[7]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[8]_INST_0 
       (.I0(\s00_axi_rdata[8]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[8]),
        .I4(sel0[0]),
        .I5(slv_reg3[8]),
        .O(s00_axi_rdata[8]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[8]_INST_0_i_1 
       (.I0(slv_reg7[8]),
        .I1(slv_reg6[8]),
        .I2(sel0[1]),
        .I3(slv_reg5[8]),
        .I4(sel0[0]),
        .I5(slv_reg4[8]),
        .O(\s00_axi_rdata[8]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \s00_axi_rdata[9]_INST_0 
       (.I0(\s00_axi_rdata[9]_INST_0_i_1_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(slv_reg2[9]),
        .I4(sel0[0]),
        .I5(slv_reg3[9]),
        .O(s00_axi_rdata[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s00_axi_rdata[9]_INST_0_i_1 
       (.I0(slv_reg7[9]),
        .I1(slv_reg6[9]),
        .I2(sel0[1]),
        .I3(slv_reg5[9]),
        .I4(sel0[0]),
        .I5(slv_reg4[9]),
        .O(\s00_axi_rdata[9]_INST_0_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg2[15]_i_1 
       (.I0(\slv_reg2[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[1]),
        .O(p_1_in[15]));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg2[23]_i_1 
       (.I0(\slv_reg2[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[2]),
        .O(p_1_in[23]));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg2[31]_i_1 
       (.I0(\slv_reg2[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[3]),
        .O(p_1_in[31]));
  LUT6 #(
    .INIT(64'h0000000054040000)) 
    \slv_reg2[31]_i_2 
       (.I0(\slv_reg2[31]_i_3_n_0 ),
        .I1(\axi_awaddr_reg_n_0_[3] ),
        .I2(s00_axi_awvalid),
        .I3(s00_axi_awaddr[1]),
        .I4(s00_axi_wvalid),
        .I5(\slv_reg2[31]_i_4_n_0 ),
        .O(\slv_reg2[31]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \slv_reg2[31]_i_3 
       (.I0(s00_axi_awaddr[2]),
        .I1(s00_axi_awvalid),
        .I2(\axi_awaddr_reg_n_0_[4] ),
        .O(\slv_reg2[31]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \slv_reg2[31]_i_4 
       (.I0(s00_axi_awaddr[0]),
        .I1(s00_axi_awvalid),
        .I2(\axi_awaddr_reg_n_0_[2] ),
        .O(\slv_reg2[31]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg2[7]_i_1 
       (.I0(\slv_reg2[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[0]),
        .O(p_1_in[7]));
  FDRE \slv_reg2_reg[0] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[7]),
        .D(s00_axi_wdata[0]),
        .Q(slv_reg2[0]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[10] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[15]),
        .D(s00_axi_wdata[10]),
        .Q(slv_reg2[10]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[11] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[15]),
        .D(s00_axi_wdata[11]),
        .Q(slv_reg2[11]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[12] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[15]),
        .D(s00_axi_wdata[12]),
        .Q(slv_reg2[12]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[13] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[15]),
        .D(s00_axi_wdata[13]),
        .Q(slv_reg2[13]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[14] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[15]),
        .D(s00_axi_wdata[14]),
        .Q(slv_reg2[14]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[15] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[15]),
        .D(s00_axi_wdata[15]),
        .Q(slv_reg2[15]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[16] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[23]),
        .D(s00_axi_wdata[16]),
        .Q(slv_reg2[16]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[17] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[23]),
        .D(s00_axi_wdata[17]),
        .Q(slv_reg2[17]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[18] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[23]),
        .D(s00_axi_wdata[18]),
        .Q(slv_reg2[18]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[19] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[23]),
        .D(s00_axi_wdata[19]),
        .Q(slv_reg2[19]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[1] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[7]),
        .D(s00_axi_wdata[1]),
        .Q(slv_reg2[1]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[20] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[23]),
        .D(s00_axi_wdata[20]),
        .Q(slv_reg2[20]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[21] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[23]),
        .D(s00_axi_wdata[21]),
        .Q(slv_reg2[21]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[22] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[23]),
        .D(s00_axi_wdata[22]),
        .Q(slv_reg2[22]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[23] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[23]),
        .D(s00_axi_wdata[23]),
        .Q(slv_reg2[23]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[24] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[31]),
        .D(s00_axi_wdata[24]),
        .Q(slv_reg2[24]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[25] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[31]),
        .D(s00_axi_wdata[25]),
        .Q(slv_reg2[25]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[26] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[31]),
        .D(s00_axi_wdata[26]),
        .Q(slv_reg2[26]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[27] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[31]),
        .D(s00_axi_wdata[27]),
        .Q(slv_reg2[27]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[28] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[31]),
        .D(s00_axi_wdata[28]),
        .Q(slv_reg2[28]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[29] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[31]),
        .D(s00_axi_wdata[29]),
        .Q(slv_reg2[29]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[2] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[7]),
        .D(s00_axi_wdata[2]),
        .Q(slv_reg2[2]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[30] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[31]),
        .D(s00_axi_wdata[30]),
        .Q(slv_reg2[30]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[31] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[31]),
        .D(s00_axi_wdata[31]),
        .Q(slv_reg2[31]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[3] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[7]),
        .D(s00_axi_wdata[3]),
        .Q(slv_reg2[3]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[4] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[7]),
        .D(s00_axi_wdata[4]),
        .Q(slv_reg2[4]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[5] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[7]),
        .D(s00_axi_wdata[5]),
        .Q(slv_reg2[5]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[6] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[7]),
        .D(s00_axi_wdata[6]),
        .Q(slv_reg2[6]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[7] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[7]),
        .D(s00_axi_wdata[7]),
        .Q(slv_reg2[7]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[8] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[15]),
        .D(s00_axi_wdata[8]),
        .Q(slv_reg2[8]),
        .R(dht11_n_1));
  FDRE \slv_reg2_reg[9] 
       (.C(s00_axi_aclk),
        .CE(p_1_in[15]),
        .D(s00_axi_wdata[9]),
        .Q(slv_reg2[9]),
        .R(dht11_n_1));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg3[15]_i_1 
       (.I0(\slv_reg3[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[1]),
        .O(\slv_reg3[15]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg3[23]_i_1 
       (.I0(\slv_reg3[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[2]),
        .O(\slv_reg3[23]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg3[31]_i_1 
       (.I0(\slv_reg3[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[3]),
        .O(\slv_reg3[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h5404000000000000)) 
    \slv_reg3[31]_i_2 
       (.I0(\slv_reg2[31]_i_3_n_0 ),
        .I1(\axi_awaddr_reg_n_0_[3] ),
        .I2(s00_axi_awvalid),
        .I3(s00_axi_awaddr[1]),
        .I4(s00_axi_wvalid),
        .I5(\slv_reg2[31]_i_4_n_0 ),
        .O(\slv_reg3[31]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg3[7]_i_1 
       (.I0(\slv_reg3[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[0]),
        .O(\slv_reg3[7]_i_1_n_0 ));
  FDRE \slv_reg3_reg[0] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[7]_i_1_n_0 ),
        .D(s00_axi_wdata[0]),
        .Q(slv_reg3[0]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[10] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[15]_i_1_n_0 ),
        .D(s00_axi_wdata[10]),
        .Q(slv_reg3[10]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[11] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[15]_i_1_n_0 ),
        .D(s00_axi_wdata[11]),
        .Q(slv_reg3[11]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[12] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[15]_i_1_n_0 ),
        .D(s00_axi_wdata[12]),
        .Q(slv_reg3[12]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[13] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[15]_i_1_n_0 ),
        .D(s00_axi_wdata[13]),
        .Q(slv_reg3[13]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[14] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[15]_i_1_n_0 ),
        .D(s00_axi_wdata[14]),
        .Q(slv_reg3[14]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[15] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[15]_i_1_n_0 ),
        .D(s00_axi_wdata[15]),
        .Q(slv_reg3[15]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[16] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[23]_i_1_n_0 ),
        .D(s00_axi_wdata[16]),
        .Q(slv_reg3[16]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[17] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[23]_i_1_n_0 ),
        .D(s00_axi_wdata[17]),
        .Q(slv_reg3[17]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[18] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[23]_i_1_n_0 ),
        .D(s00_axi_wdata[18]),
        .Q(slv_reg3[18]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[19] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[23]_i_1_n_0 ),
        .D(s00_axi_wdata[19]),
        .Q(slv_reg3[19]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[1] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[7]_i_1_n_0 ),
        .D(s00_axi_wdata[1]),
        .Q(slv_reg3[1]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[20] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[23]_i_1_n_0 ),
        .D(s00_axi_wdata[20]),
        .Q(slv_reg3[20]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[21] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[23]_i_1_n_0 ),
        .D(s00_axi_wdata[21]),
        .Q(slv_reg3[21]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[22] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[23]_i_1_n_0 ),
        .D(s00_axi_wdata[22]),
        .Q(slv_reg3[22]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[23] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[23]_i_1_n_0 ),
        .D(s00_axi_wdata[23]),
        .Q(slv_reg3[23]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[24] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[31]_i_1_n_0 ),
        .D(s00_axi_wdata[24]),
        .Q(slv_reg3[24]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[25] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[31]_i_1_n_0 ),
        .D(s00_axi_wdata[25]),
        .Q(slv_reg3[25]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[26] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[31]_i_1_n_0 ),
        .D(s00_axi_wdata[26]),
        .Q(slv_reg3[26]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[27] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[31]_i_1_n_0 ),
        .D(s00_axi_wdata[27]),
        .Q(slv_reg3[27]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[28] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[31]_i_1_n_0 ),
        .D(s00_axi_wdata[28]),
        .Q(slv_reg3[28]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[29] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[31]_i_1_n_0 ),
        .D(s00_axi_wdata[29]),
        .Q(slv_reg3[29]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[2] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[7]_i_1_n_0 ),
        .D(s00_axi_wdata[2]),
        .Q(slv_reg3[2]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[30] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[31]_i_1_n_0 ),
        .D(s00_axi_wdata[30]),
        .Q(slv_reg3[30]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[31] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[31]_i_1_n_0 ),
        .D(s00_axi_wdata[31]),
        .Q(slv_reg3[31]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[3] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[7]_i_1_n_0 ),
        .D(s00_axi_wdata[3]),
        .Q(slv_reg3[3]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[4] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[7]_i_1_n_0 ),
        .D(s00_axi_wdata[4]),
        .Q(slv_reg3[4]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[5] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[7]_i_1_n_0 ),
        .D(s00_axi_wdata[5]),
        .Q(slv_reg3[5]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[6] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[7]_i_1_n_0 ),
        .D(s00_axi_wdata[6]),
        .Q(slv_reg3[6]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[7] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[7]_i_1_n_0 ),
        .D(s00_axi_wdata[7]),
        .Q(slv_reg3[7]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[8] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[15]_i_1_n_0 ),
        .D(s00_axi_wdata[8]),
        .Q(slv_reg3[8]),
        .R(dht11_n_1));
  FDRE \slv_reg3_reg[9] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg3[15]_i_1_n_0 ),
        .D(s00_axi_wdata[9]),
        .Q(slv_reg3[9]),
        .R(dht11_n_1));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg4[15]_i_1 
       (.I0(\slv_reg4[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[1]),
        .O(\slv_reg4[15]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg4[23]_i_1 
       (.I0(\slv_reg4[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[2]),
        .O(\slv_reg4[23]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg4[31]_i_1 
       (.I0(\slv_reg4[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[3]),
        .O(\slv_reg4[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000088808)) 
    \slv_reg4[31]_i_2 
       (.I0(s00_axi_wvalid),
        .I1(\slv_reg2[31]_i_3_n_0 ),
        .I2(\axi_awaddr_reg_n_0_[3] ),
        .I3(s00_axi_awvalid),
        .I4(s00_axi_awaddr[1]),
        .I5(\slv_reg2[31]_i_4_n_0 ),
        .O(\slv_reg4[31]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg4[7]_i_1 
       (.I0(\slv_reg4[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[0]),
        .O(\slv_reg4[7]_i_1_n_0 ));
  FDRE \slv_reg4_reg[0] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[7]_i_1_n_0 ),
        .D(s00_axi_wdata[0]),
        .Q(slv_reg4[0]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[10] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[15]_i_1_n_0 ),
        .D(s00_axi_wdata[10]),
        .Q(slv_reg4[10]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[11] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[15]_i_1_n_0 ),
        .D(s00_axi_wdata[11]),
        .Q(slv_reg4[11]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[12] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[15]_i_1_n_0 ),
        .D(s00_axi_wdata[12]),
        .Q(slv_reg4[12]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[13] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[15]_i_1_n_0 ),
        .D(s00_axi_wdata[13]),
        .Q(slv_reg4[13]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[14] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[15]_i_1_n_0 ),
        .D(s00_axi_wdata[14]),
        .Q(slv_reg4[14]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[15] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[15]_i_1_n_0 ),
        .D(s00_axi_wdata[15]),
        .Q(slv_reg4[15]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[16] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[23]_i_1_n_0 ),
        .D(s00_axi_wdata[16]),
        .Q(slv_reg4[16]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[17] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[23]_i_1_n_0 ),
        .D(s00_axi_wdata[17]),
        .Q(slv_reg4[17]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[18] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[23]_i_1_n_0 ),
        .D(s00_axi_wdata[18]),
        .Q(slv_reg4[18]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[19] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[23]_i_1_n_0 ),
        .D(s00_axi_wdata[19]),
        .Q(slv_reg4[19]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[1] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[7]_i_1_n_0 ),
        .D(s00_axi_wdata[1]),
        .Q(slv_reg4[1]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[20] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[23]_i_1_n_0 ),
        .D(s00_axi_wdata[20]),
        .Q(slv_reg4[20]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[21] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[23]_i_1_n_0 ),
        .D(s00_axi_wdata[21]),
        .Q(slv_reg4[21]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[22] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[23]_i_1_n_0 ),
        .D(s00_axi_wdata[22]),
        .Q(slv_reg4[22]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[23] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[23]_i_1_n_0 ),
        .D(s00_axi_wdata[23]),
        .Q(slv_reg4[23]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[24] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[31]_i_1_n_0 ),
        .D(s00_axi_wdata[24]),
        .Q(slv_reg4[24]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[25] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[31]_i_1_n_0 ),
        .D(s00_axi_wdata[25]),
        .Q(slv_reg4[25]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[26] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[31]_i_1_n_0 ),
        .D(s00_axi_wdata[26]),
        .Q(slv_reg4[26]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[27] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[31]_i_1_n_0 ),
        .D(s00_axi_wdata[27]),
        .Q(slv_reg4[27]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[28] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[31]_i_1_n_0 ),
        .D(s00_axi_wdata[28]),
        .Q(slv_reg4[28]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[29] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[31]_i_1_n_0 ),
        .D(s00_axi_wdata[29]),
        .Q(slv_reg4[29]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[2] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[7]_i_1_n_0 ),
        .D(s00_axi_wdata[2]),
        .Q(slv_reg4[2]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[30] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[31]_i_1_n_0 ),
        .D(s00_axi_wdata[30]),
        .Q(slv_reg4[30]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[31] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[31]_i_1_n_0 ),
        .D(s00_axi_wdata[31]),
        .Q(slv_reg4[31]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[3] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[7]_i_1_n_0 ),
        .D(s00_axi_wdata[3]),
        .Q(slv_reg4[3]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[4] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[7]_i_1_n_0 ),
        .D(s00_axi_wdata[4]),
        .Q(slv_reg4[4]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[5] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[7]_i_1_n_0 ),
        .D(s00_axi_wdata[5]),
        .Q(slv_reg4[5]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[6] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[7]_i_1_n_0 ),
        .D(s00_axi_wdata[6]),
        .Q(slv_reg4[6]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[7] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[7]_i_1_n_0 ),
        .D(s00_axi_wdata[7]),
        .Q(slv_reg4[7]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[8] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[15]_i_1_n_0 ),
        .D(s00_axi_wdata[8]),
        .Q(slv_reg4[8]),
        .R(dht11_n_1));
  FDRE \slv_reg4_reg[9] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg4[15]_i_1_n_0 ),
        .D(s00_axi_wdata[9]),
        .Q(slv_reg4[9]),
        .R(dht11_n_1));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg5[15]_i_1 
       (.I0(\slv_reg5[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[1]),
        .O(\slv_reg5[15]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg5[23]_i_1 
       (.I0(\slv_reg5[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[2]),
        .O(\slv_reg5[23]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg5[31]_i_1 
       (.I0(\slv_reg5[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[3]),
        .O(\slv_reg5[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0008880800000000)) 
    \slv_reg5[31]_i_2 
       (.I0(s00_axi_wvalid),
        .I1(\slv_reg2[31]_i_3_n_0 ),
        .I2(\axi_awaddr_reg_n_0_[3] ),
        .I3(s00_axi_awvalid),
        .I4(s00_axi_awaddr[1]),
        .I5(\slv_reg2[31]_i_4_n_0 ),
        .O(\slv_reg5[31]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg5[7]_i_1 
       (.I0(\slv_reg5[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[0]),
        .O(\slv_reg5[7]_i_1_n_0 ));
  FDRE \slv_reg5_reg[0] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[7]_i_1_n_0 ),
        .D(s00_axi_wdata[0]),
        .Q(slv_reg5[0]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[10] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[15]_i_1_n_0 ),
        .D(s00_axi_wdata[10]),
        .Q(slv_reg5[10]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[11] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[15]_i_1_n_0 ),
        .D(s00_axi_wdata[11]),
        .Q(slv_reg5[11]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[12] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[15]_i_1_n_0 ),
        .D(s00_axi_wdata[12]),
        .Q(slv_reg5[12]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[13] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[15]_i_1_n_0 ),
        .D(s00_axi_wdata[13]),
        .Q(slv_reg5[13]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[14] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[15]_i_1_n_0 ),
        .D(s00_axi_wdata[14]),
        .Q(slv_reg5[14]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[15] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[15]_i_1_n_0 ),
        .D(s00_axi_wdata[15]),
        .Q(slv_reg5[15]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[16] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[23]_i_1_n_0 ),
        .D(s00_axi_wdata[16]),
        .Q(slv_reg5[16]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[17] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[23]_i_1_n_0 ),
        .D(s00_axi_wdata[17]),
        .Q(slv_reg5[17]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[18] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[23]_i_1_n_0 ),
        .D(s00_axi_wdata[18]),
        .Q(slv_reg5[18]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[19] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[23]_i_1_n_0 ),
        .D(s00_axi_wdata[19]),
        .Q(slv_reg5[19]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[1] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[7]_i_1_n_0 ),
        .D(s00_axi_wdata[1]),
        .Q(slv_reg5[1]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[20] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[23]_i_1_n_0 ),
        .D(s00_axi_wdata[20]),
        .Q(slv_reg5[20]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[21] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[23]_i_1_n_0 ),
        .D(s00_axi_wdata[21]),
        .Q(slv_reg5[21]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[22] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[23]_i_1_n_0 ),
        .D(s00_axi_wdata[22]),
        .Q(slv_reg5[22]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[23] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[23]_i_1_n_0 ),
        .D(s00_axi_wdata[23]),
        .Q(slv_reg5[23]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[24] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[31]_i_1_n_0 ),
        .D(s00_axi_wdata[24]),
        .Q(slv_reg5[24]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[25] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[31]_i_1_n_0 ),
        .D(s00_axi_wdata[25]),
        .Q(slv_reg5[25]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[26] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[31]_i_1_n_0 ),
        .D(s00_axi_wdata[26]),
        .Q(slv_reg5[26]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[27] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[31]_i_1_n_0 ),
        .D(s00_axi_wdata[27]),
        .Q(slv_reg5[27]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[28] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[31]_i_1_n_0 ),
        .D(s00_axi_wdata[28]),
        .Q(slv_reg5[28]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[29] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[31]_i_1_n_0 ),
        .D(s00_axi_wdata[29]),
        .Q(slv_reg5[29]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[2] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[7]_i_1_n_0 ),
        .D(s00_axi_wdata[2]),
        .Q(slv_reg5[2]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[30] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[31]_i_1_n_0 ),
        .D(s00_axi_wdata[30]),
        .Q(slv_reg5[30]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[31] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[31]_i_1_n_0 ),
        .D(s00_axi_wdata[31]),
        .Q(slv_reg5[31]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[3] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[7]_i_1_n_0 ),
        .D(s00_axi_wdata[3]),
        .Q(slv_reg5[3]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[4] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[7]_i_1_n_0 ),
        .D(s00_axi_wdata[4]),
        .Q(slv_reg5[4]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[5] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[7]_i_1_n_0 ),
        .D(s00_axi_wdata[5]),
        .Q(slv_reg5[5]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[6] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[7]_i_1_n_0 ),
        .D(s00_axi_wdata[6]),
        .Q(slv_reg5[6]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[7] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[7]_i_1_n_0 ),
        .D(s00_axi_wdata[7]),
        .Q(slv_reg5[7]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[8] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[15]_i_1_n_0 ),
        .D(s00_axi_wdata[8]),
        .Q(slv_reg5[8]),
        .R(dht11_n_1));
  FDRE \slv_reg5_reg[9] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg5[15]_i_1_n_0 ),
        .D(s00_axi_wdata[9]),
        .Q(slv_reg5[9]),
        .R(dht11_n_1));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg6[15]_i_1 
       (.I0(\slv_reg6[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[1]),
        .O(\slv_reg6[15]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg6[23]_i_1 
       (.I0(\slv_reg6[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[2]),
        .O(\slv_reg6[23]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg6[31]_i_1 
       (.I0(\slv_reg6[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[3]),
        .O(\slv_reg6[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000A8080000)) 
    \slv_reg6[31]_i_2 
       (.I0(\slv_reg2[31]_i_3_n_0 ),
        .I1(\axi_awaddr_reg_n_0_[3] ),
        .I2(s00_axi_awvalid),
        .I3(s00_axi_awaddr[1]),
        .I4(s00_axi_wvalid),
        .I5(\slv_reg2[31]_i_4_n_0 ),
        .O(\slv_reg6[31]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg6[7]_i_1 
       (.I0(\slv_reg6[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[0]),
        .O(\slv_reg6[7]_i_1_n_0 ));
  FDRE \slv_reg6_reg[0] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[7]_i_1_n_0 ),
        .D(s00_axi_wdata[0]),
        .Q(slv_reg6[0]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[10] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[15]_i_1_n_0 ),
        .D(s00_axi_wdata[10]),
        .Q(slv_reg6[10]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[11] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[15]_i_1_n_0 ),
        .D(s00_axi_wdata[11]),
        .Q(slv_reg6[11]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[12] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[15]_i_1_n_0 ),
        .D(s00_axi_wdata[12]),
        .Q(slv_reg6[12]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[13] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[15]_i_1_n_0 ),
        .D(s00_axi_wdata[13]),
        .Q(slv_reg6[13]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[14] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[15]_i_1_n_0 ),
        .D(s00_axi_wdata[14]),
        .Q(slv_reg6[14]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[15] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[15]_i_1_n_0 ),
        .D(s00_axi_wdata[15]),
        .Q(slv_reg6[15]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[16] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[23]_i_1_n_0 ),
        .D(s00_axi_wdata[16]),
        .Q(slv_reg6[16]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[17] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[23]_i_1_n_0 ),
        .D(s00_axi_wdata[17]),
        .Q(slv_reg6[17]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[18] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[23]_i_1_n_0 ),
        .D(s00_axi_wdata[18]),
        .Q(slv_reg6[18]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[19] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[23]_i_1_n_0 ),
        .D(s00_axi_wdata[19]),
        .Q(slv_reg6[19]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[1] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[7]_i_1_n_0 ),
        .D(s00_axi_wdata[1]),
        .Q(slv_reg6[1]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[20] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[23]_i_1_n_0 ),
        .D(s00_axi_wdata[20]),
        .Q(slv_reg6[20]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[21] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[23]_i_1_n_0 ),
        .D(s00_axi_wdata[21]),
        .Q(slv_reg6[21]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[22] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[23]_i_1_n_0 ),
        .D(s00_axi_wdata[22]),
        .Q(slv_reg6[22]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[23] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[23]_i_1_n_0 ),
        .D(s00_axi_wdata[23]),
        .Q(slv_reg6[23]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[24] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[31]_i_1_n_0 ),
        .D(s00_axi_wdata[24]),
        .Q(slv_reg6[24]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[25] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[31]_i_1_n_0 ),
        .D(s00_axi_wdata[25]),
        .Q(slv_reg6[25]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[26] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[31]_i_1_n_0 ),
        .D(s00_axi_wdata[26]),
        .Q(slv_reg6[26]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[27] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[31]_i_1_n_0 ),
        .D(s00_axi_wdata[27]),
        .Q(slv_reg6[27]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[28] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[31]_i_1_n_0 ),
        .D(s00_axi_wdata[28]),
        .Q(slv_reg6[28]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[29] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[31]_i_1_n_0 ),
        .D(s00_axi_wdata[29]),
        .Q(slv_reg6[29]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[2] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[7]_i_1_n_0 ),
        .D(s00_axi_wdata[2]),
        .Q(slv_reg6[2]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[30] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[31]_i_1_n_0 ),
        .D(s00_axi_wdata[30]),
        .Q(slv_reg6[30]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[31] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[31]_i_1_n_0 ),
        .D(s00_axi_wdata[31]),
        .Q(slv_reg6[31]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[3] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[7]_i_1_n_0 ),
        .D(s00_axi_wdata[3]),
        .Q(slv_reg6[3]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[4] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[7]_i_1_n_0 ),
        .D(s00_axi_wdata[4]),
        .Q(slv_reg6[4]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[5] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[7]_i_1_n_0 ),
        .D(s00_axi_wdata[5]),
        .Q(slv_reg6[5]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[6] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[7]_i_1_n_0 ),
        .D(s00_axi_wdata[6]),
        .Q(slv_reg6[6]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[7] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[7]_i_1_n_0 ),
        .D(s00_axi_wdata[7]),
        .Q(slv_reg6[7]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[8] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[15]_i_1_n_0 ),
        .D(s00_axi_wdata[8]),
        .Q(slv_reg6[8]),
        .R(dht11_n_1));
  FDRE \slv_reg6_reg[9] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg6[15]_i_1_n_0 ),
        .D(s00_axi_wdata[9]),
        .Q(slv_reg6[9]),
        .R(dht11_n_1));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg7[15]_i_1 
       (.I0(\slv_reg7[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[1]),
        .O(\slv_reg7[15]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg7[23]_i_1 
       (.I0(\slv_reg7[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[2]),
        .O(\slv_reg7[23]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg7[31]_i_1 
       (.I0(\slv_reg7[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[3]),
        .O(\slv_reg7[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hA808000000000000)) 
    \slv_reg7[31]_i_2 
       (.I0(\slv_reg2[31]_i_3_n_0 ),
        .I1(\axi_awaddr_reg_n_0_[3] ),
        .I2(s00_axi_awvalid),
        .I3(s00_axi_awaddr[1]),
        .I4(s00_axi_wvalid),
        .I5(\slv_reg2[31]_i_4_n_0 ),
        .O(\slv_reg7[31]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \slv_reg7[7]_i_1 
       (.I0(\slv_reg7[31]_i_2_n_0 ),
        .I1(s00_axi_wstrb[0]),
        .O(\slv_reg7[7]_i_1_n_0 ));
  FDRE \slv_reg7_reg[0] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[7]_i_1_n_0 ),
        .D(s00_axi_wdata[0]),
        .Q(slv_reg7[0]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[10] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[15]_i_1_n_0 ),
        .D(s00_axi_wdata[10]),
        .Q(slv_reg7[10]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[11] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[15]_i_1_n_0 ),
        .D(s00_axi_wdata[11]),
        .Q(slv_reg7[11]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[12] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[15]_i_1_n_0 ),
        .D(s00_axi_wdata[12]),
        .Q(slv_reg7[12]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[13] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[15]_i_1_n_0 ),
        .D(s00_axi_wdata[13]),
        .Q(slv_reg7[13]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[14] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[15]_i_1_n_0 ),
        .D(s00_axi_wdata[14]),
        .Q(slv_reg7[14]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[15] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[15]_i_1_n_0 ),
        .D(s00_axi_wdata[15]),
        .Q(slv_reg7[15]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[16] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[23]_i_1_n_0 ),
        .D(s00_axi_wdata[16]),
        .Q(slv_reg7[16]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[17] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[23]_i_1_n_0 ),
        .D(s00_axi_wdata[17]),
        .Q(slv_reg7[17]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[18] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[23]_i_1_n_0 ),
        .D(s00_axi_wdata[18]),
        .Q(slv_reg7[18]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[19] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[23]_i_1_n_0 ),
        .D(s00_axi_wdata[19]),
        .Q(slv_reg7[19]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[1] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[7]_i_1_n_0 ),
        .D(s00_axi_wdata[1]),
        .Q(slv_reg7[1]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[20] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[23]_i_1_n_0 ),
        .D(s00_axi_wdata[20]),
        .Q(slv_reg7[20]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[21] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[23]_i_1_n_0 ),
        .D(s00_axi_wdata[21]),
        .Q(slv_reg7[21]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[22] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[23]_i_1_n_0 ),
        .D(s00_axi_wdata[22]),
        .Q(slv_reg7[22]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[23] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[23]_i_1_n_0 ),
        .D(s00_axi_wdata[23]),
        .Q(slv_reg7[23]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[24] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[31]_i_1_n_0 ),
        .D(s00_axi_wdata[24]),
        .Q(slv_reg7[24]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[25] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[31]_i_1_n_0 ),
        .D(s00_axi_wdata[25]),
        .Q(slv_reg7[25]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[26] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[31]_i_1_n_0 ),
        .D(s00_axi_wdata[26]),
        .Q(slv_reg7[26]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[27] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[31]_i_1_n_0 ),
        .D(s00_axi_wdata[27]),
        .Q(slv_reg7[27]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[28] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[31]_i_1_n_0 ),
        .D(s00_axi_wdata[28]),
        .Q(slv_reg7[28]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[29] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[31]_i_1_n_0 ),
        .D(s00_axi_wdata[29]),
        .Q(slv_reg7[29]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[2] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[7]_i_1_n_0 ),
        .D(s00_axi_wdata[2]),
        .Q(slv_reg7[2]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[30] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[31]_i_1_n_0 ),
        .D(s00_axi_wdata[30]),
        .Q(slv_reg7[30]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[31] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[31]_i_1_n_0 ),
        .D(s00_axi_wdata[31]),
        .Q(slv_reg7[31]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[3] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[7]_i_1_n_0 ),
        .D(s00_axi_wdata[3]),
        .Q(slv_reg7[3]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[4] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[7]_i_1_n_0 ),
        .D(s00_axi_wdata[4]),
        .Q(slv_reg7[4]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[5] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[7]_i_1_n_0 ),
        .D(s00_axi_wdata[5]),
        .Q(slv_reg7[5]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[6] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[7]_i_1_n_0 ),
        .D(s00_axi_wdata[6]),
        .Q(slv_reg7[6]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[7] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[7]_i_1_n_0 ),
        .D(s00_axi_wdata[7]),
        .Q(slv_reg7[7]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[8] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[15]_i_1_n_0 ),
        .D(s00_axi_wdata[8]),
        .Q(slv_reg7[8]),
        .R(dht11_n_1));
  FDRE \slv_reg7_reg[9] 
       (.C(s00_axi_aclk),
        .CE(\slv_reg7[15]_i_1_n_0 ),
        .D(s00_axi_wdata[9]),
        .Q(slv_reg7[9]),
        .R(dht11_n_1));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
