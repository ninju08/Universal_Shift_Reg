class USR_env ;

 virtual USR_if.WR_DRV_MP wr_drv_if ;
 virtual USR_if.WR_MON_MP wr_mon_if ;
 virtual USR_if.RD_MON_MP rd_mon_if ;

  mailbox #(USR_trans) gen2wr =  new();
  mailbox #(USR_trans) wr2rm =  new();
  mailbox #(USR_trans) mon2sb =  new();
  mailbox #(USR_trans) rm2sb =  new();
  


  USR_gen            gen_h ;
  USR_write_driver   wr_drv_h;
  USR_write_monitor  wr_mon_h ;
  USR_read_monitor   rd_mon_h;
  USR_sb             sb_h ;
  USR_ref_model      ref_mod_h;




 function new(virtual USR_if.WR_DRV_MP wr_drv_if ,
              virtual USR_if.WR_MON_MP wr_mon_if ,
              virtual USR_if.RD_MON_MP rd_mon_if );
              this.wr_drv_if = wr_drv_if ;
              this.wr_mon_if = wr_mon_if ;
              this.rd_mon_if = rd_mon_if;
 endfunction 

 virtual task build ();
  gen_h = new(gen2wr);
  wr_drv_h = new(wr_drv_if,gen2wr);
  wr_mon_h = new(wr_mon_if,wr2rm);
  rd_mon_h = new(rd_mon_if,mon2sb);
  ref_mod_h = new(wr2rm,rm2sb);
  sb_h  = new(rm2sb,mon2sb);
endtask 

virtual task start;
  gen_h.start();
  wr_drv_h.start();
  wr_mon_h.start();
  rd_mon_h.start();
  ref_mod_h.start();
  sb_h.start();
endtask 


 virtual task stop();
   wait(sb_h.DONE.triggered);
 endtask 

virtual task run();
  start();
  stop();
  sb_h.report();
endtask 

endclass
