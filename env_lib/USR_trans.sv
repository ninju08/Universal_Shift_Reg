class USR_trans ;

 rand bit clr;
 rand bit shift_en ;
 rand bit[1:0] sel;
 rand bit [3:0] data_in;
      bit [3:0] out;

 
  static int trans_id;
  static int no_of_clr;
 

 constraint CLEAR{clr dist{1:=20 ,0:=100};}
 constraint ENABLE{shift_en dist{1:=80,0:=20};}
 constraint SELECT {sel inside {[0:2]};}

 
 function void post_randomize();
  trans_id++;
   if(this.clr)
   no_of_clr++;
  
   this.display("\t RANDOMIZED DATA");
 endfunction 


  virtual function void display(input string message);
  $display("===============================================================================");
  $display("message = %s",message);
  $display("clr = %d, sel = %d, shift_en = %d  ",clr,sel,shift_en);
  $display("data_in = %b, out = %b",data_in,out);
  $display("===============================================================================");
  endfunction

endclass
