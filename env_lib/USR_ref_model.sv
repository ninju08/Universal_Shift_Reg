class USR_ref_model;
 
 USR_trans wrmon_data ;

 static bit [3:0] ref_out =0 ;
 integer i ;  

 mailbox #(USR_trans) wr2rm;
 mailbox #(USR_trans) rm2sb;
  

 
 function new(mailbox #(USR_trans) wr2rm,
               mailbox #(USR_trans) rm2sb);
        this.wr2rm = wr2rm;
        this.rm2sb = rm2sb ;
endfunction 

  virtual task  start();
    fork 
        forever 
          begin 
            wr2rm.get(wrmon_data);
       //     verify(wrmon_data);
            wrmon_data.out = ref_out ;
            rm2sb.put(wrmon_data);
          end 
   join_none 
 endtask 

endclass
