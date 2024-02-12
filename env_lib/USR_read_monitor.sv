class USR_read_monitor;

 virtual USR_if.RD_MON_MP rd_mon_if ;

 USR_trans rddata ,data2sb ;

 
 mailbox #(USR_trans) mon2sb ;

 function new(virtual USR_if.RD_MON_MP rd_mon_if,
              mailbox #(USR_trans) mon2sb );
     this.rd_mon_if = rd_mon_if ;
     this.mon2sb =  mon2sb ;
    this.rddata = new ;
 endfunction 

 virtual task monitor ();
 begin 
  @(rd_mon_if.rd_mon_cb);
   begin 
    rddata.out = rd_mon_if.rd_mon_cb.out;
    rddata.display("DATA FROM READ MONITOR");
   end 
 end 
 endtask 

 virtual task start();
   fork 
     forever  
       begin 
          monitor();
         
          data2sb = new rddata;
         
          mon2sb.put(data2sb);
       end 
    join_none 
endtask 

endclass

