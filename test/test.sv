class USR_base_test ;

 virtual USR_if.WR_DRV_MP wr_drv_if ;
 virtual USR_if.WR_MON_MP wr_mon_if;
 virtual USR_if.RD_MON_MP rd_mon_if;

 USR_env env_h ;


  function new( virtual USR_if.WR_DRV_MP wr_drv_if ,
                virtual USR_if.WR_MON_MP wr_mon_if,
                virtual USR_if.RD_MON_MP rd_mon_if);

       this.wr_drv_if = wr_drv_if ;
       this.wr_mon_if = wr_mon_if;
       this.rd_mon_if = rd_mon_if;
       env_h=new (wr_drv_if,wr_mon_if,rd_mon_if);

  endfunction


  virtual task build();
   env_h.build();
  endtask

 virtual task run();
  env_h.run();
 endtask


endclass
