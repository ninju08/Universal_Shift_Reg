package USR_pkg;

  int number_of_transactions = 1;

  `include "USR_trans.sv"
  `include "USR_gen.sv"
  `include "USR_write_monitor.sv"
  `include "USR_write_driver.sv"
  `include "USR_read_monitor.sv"
  `include "USR_sb.sv"
  `include "USR_ref_model.sv"
  `include "USR_env.sv"
  `include "test.sv"

endpackage
