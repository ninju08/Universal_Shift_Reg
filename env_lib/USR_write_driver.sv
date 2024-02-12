class USR_write_driver ;

  USR_trans data2duv ;
 
  mailbox #(USR_trans) gen2wr;

 virtual USR_if.WR_DRV_MP wr_drv_if ;

 function new ( virtual USR_if.WR_DRV_MP wr_drv_if,
                mailbox #(USR_trans) gen2wr) ;

     
      this.wr_drv_if = wr_drv_if;
       this.gen2wr = gen2wr ;

  endfunction 

  virtual task drive ();
   begin 
    @(wr_drv_if.wr_drv_cb);
      wr_drv_if.wr_drv_cb.sel <= data2duv.sel;
      wr_drv_if.wr_drv_cb.data_in<=data2duv.data_in;
      wr_drv_if.wr_drv_cb.shift_en<=data2duv.shift_en;
      wr_drv_if.wr_drv_cb.clr <= data2duv.clr;
   end 
 endtask 

  virtual task start();
   fork 
    forever
     begin
      gen2wr.get(data2duv);
      drive();
     end 
   join_none
 endtask 

endclass
