module top();

  import USR_pkg::*;

  parameter cycle = 10 ;
 
  reg clock ;

  USR_if DUV_IF(clock);

 USR_base_test base_test_h ;



         USR  DUT(.clk(clock),
               .data_in(DUV_IF.data_in),
               .clr(DUV_IF.clr),
               .shift_en(DUV_IF.shift_en),
               .sel(DUV_IF.sel),
               .out(DUV_IF.out));

   
 initial 
    begin 
      clock = 1'b0;
      forever #(cycle/2) clock = ~clock;
   end 

 initial 
   begin  
     if($test$plusargs("TEST1"))
      begin 
     base_test_h = new(DUV_IF,DUV_IF,DUV_IF);
     number_of_transactions = 200;
     base_test_h.build();
     base_test_h.run();
   $finish ;
  end 

  end 
endmodule
