//Transaction Class
class transaction;
  rand bit din;
  bit dout;
  
  function transaction copy();
    copy=new();
    
    copy.din=this.din;
    copy.dout=this.dout;
  endfunction
  
  function void display(input string tag);
    $display("[%0s]: DIN: %0b, DOUT: %0b", tag,din,dout);
  endfunction
endclass


//Generator
class generator;
  transaction tr;
  
  mailbox #(transaction) mbx;
  mailbox #(transaction) mbxref;
  
  event sconext;
  event done;
  int count;
  
  function new(mailbox #(transaction) mbx, mailbox #(transaction) mbxref);
    
    this.mbx=mbx;
    this.mbxref=mbxref;
    tr=new();
  endfunction;
  
  
  task run();
    repeat (count) begin
      assert(tr.randomize) else $error("[GEN]: Randomization Failed");
      
      
      
      mbx.put(tr.copy);
      mbxref.put(tr.copy);
      tr.display("GEN");
      @(sconext);
    end
    ->done;
  endtask
endclass 
  
  

  

//Driver Class
class driver;
  transaction tr;
  mailbox #(transaction) mbx;
  virtual dff_if dif;
  
  function new(mailbox #(transaction) mbx);
    this.mbx=mbx;
  endfunction
  
  task reset();
    dif.reset<=1'b1;
    repeat(5) @(posedge dif.clk);
    dif.reset<=1'b0;
    @(posedge dif.clk);
    $display("Reset Done");
  endtask
  
  task run();
    forever begin
      mbx.get(tr);
      dif.din<=tr.din;
      @(posedge dif.clk);
      tr.display("DRV");
      dif.din<=1'b0;
      @(posedge dif.clk);
    end
  endtask
  
endclass

//Monitor Class
class monitor;
  transaction tr;
  mailbox #(transaction) mbx;
  virtual dff_if dif;
  function new(mailbox #(transaction) mbx);
    this.mbx=mbx;
  endfunction
  
  task run();
    tr=new();
    forever begin
      repeat(2) @(posedge dif.clk);
      tr.dout<=dif.dout;
      mbx.put(tr);
      tr.display("MON");
    end
  endtask
  
endclass

//Scoreboard

class scoreboard;
  transaction tr;
  transaction tref;
  
  mailbox #(transaction) mbx;
  mailbox #(transaction) mbxref;
  event sconext;
  
  function new(mailbox #(transaction) mbx, mailbox #(transaction) mbxref);
    this.mbx=mbx;
    this.mbxref=mbxref;
  endfunction
  
  
  task run();
    forever begin
      mbx.get(tr);
      mbxref.get(tref);
      tr.display("SCO");
      tref.display("REF");
      if(tr.dout==tref.din) begin
        $display("[SC0]: Data Matched");
      end
      else $display("[SCO]: Data Mismatched");
      $display("-----------------------------------------");
      ->sconext;
    end
  endtask
endclass

//Environment
class environment;
  generator gen;
  driver drv;
  monitor mon;
  scoreboard sco;
  event next;
  
  mailbox #(transaction) gdmbx;
  mailbox #(transaction) msmbx;
  mailbox #(transaction) mbxref;
  
  virtual dff_if dif;
  function new(virtual dff_if dif);
    gdmbx=new();
    msmbx=new();
    mbxref=new();
    gen=new(gdmbx, mbxref);
    sco=new(msmbx, mbxref);
    mon=new(msmbx);
    drv=new(gdmbx);
    this.dif=dif;
    drv.dif=dif;
    mon.dif=dif;
    gen.sconext=next;
    sco.sconext=next;
  endfunction
  
  //Pre-test
  task pre_test();
    drv.reset();
  endtask
  
  
  //Run Test
  task test();
    fork
      gen.run();
      drv.run();
      mon.run();
      sco.run();
    join_any
  endtask
  
  //Post-test
  
  task post_test();
    wait(gen.done.triggered);
    $finish;
  endtask
  
  
  task run();
    pre_test();
    test();
    post_test();
  endtask
endclass


//Testbench top
module tb;
  dff_if dif();
  dff dut(dif);
  initial begin
    dif.clk<=0;
  end
  always #10 dif.clk=~dif.clk;
  
  environment env;
  initial begin
    env=new(dif);
    env.gen.count=30;
    env.run();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule
      
  
  