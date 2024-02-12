interface USR_if (input bit clk);
  
  logic clr ;
  logic shift_en;
  logic [1:0] sel;
  logic [3:0] data_in;
  logic [3:0] out;


  clocking wr_drv_cb@(posedge clk);
   default input #1 output #1 ;
   output clr ;
   output shift_en; 
   output sel;
   output data_in;
  endclocking 

  clocking wr_mon_cb@(posedge clk);
  default input #1 output #1;
   input clr ;
   input shift_en;
   input sel;
   input data_in;
  endclocking
 
  clocking rd_mon_cb@(posedge clk);
   default input #1 output #1;
   input out;
  endclocking 

  modport WR_DRV_MP(clocking wr_drv_cb);

  modport WR_MON_MP(clocking wr_mon_cb);

  modport RD_MON_MP(clocking rd_mon_cb);
  
 endinterface
