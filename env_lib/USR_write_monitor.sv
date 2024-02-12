class USR_write_monitor ;

  USR_trans wrdata;
  USR_trans data2rm;

  virtual USR_if.WR_MON_MP wr_mon_if;

  mailbox #(USR_trans) mon2rm;

  function new( virtual USR_if.WR_MON_MP wr_mon_if,

                  mailbox #(USR_trans) mon2rm);
            this.wr_mon_if = wr_mon_if ;
            this.mon2rm = mon2rm;
            this.wrdata = new ;
  endfunction 



 virtual task monitor ();
  begin 
   @(wr_mon_if.wr_mon_cb)
     begin 
      wrdata.sel = wr_mon_if.wr_mon_cb.sel ;
      wrdata.data_in = wr_mon_if.wr_mon_cb.data_in ;
      wrdata.shift_en =  wr_mon_if.wr_mon_cb.shift_en; 
      wrdata.clr = wr_mon_if.wr_mon_cb.clr ;
      wrdata.display("DATA FROM READ MONITOR");
    end 
  end 
 endtask 



  virtual task start ();
    fork 
       forever
         begin 
           monitor();
            data2rm = new wrdata;
           mon2rm.put(data2rm);
        end 
   join_none 
endtask 

endclass
