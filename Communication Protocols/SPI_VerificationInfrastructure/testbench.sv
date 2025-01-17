//Transaction Class
class transaction;
  rand bit newd;
  rand bit [11:0] din;
  bit cs;
  bit mosi;
  
   function transaction copy();
    copy=new();
    copy.newd=this.newd;
    copy.din=this.din;
    copy.cs=this.cs;
    copy.mosi=this.mosi;
  endfunction
  
   function void display(input string tag);
    $display("[%0s]: Data new: %0b din: %0d cs: %b MOSI: %b", tag, newd, din, cs, mosi);
  endfunction
endclass
  
  
 

//Generator class
class generator;
  transaction tr;
  mailbox #(transaction) mbx;
  event done;
  int count=0;
  event drvnext;
  event sconext;
  function new(mailbox #(transaction) mbx);
    this.mbx=mbx;
    tr=new();
  endfunction
  
  task run();
    repeat(count) begin
      assert(tr.randomize) else $error("[GEN]: Randomization Failed");
      mbx.put(tr.copy);
      tr.display("GEN");
      @(drvnext);
      @(sconext);
    end
    ->done;
  endtask
endclass

//Driver class
class driver;
  transaction tr;
  virtual spi_if vif;
  mailbox #(transaction) mbx;
  mailbox #(bit [11:0]) mbxds;
  event drvnext;
  bit [11:0] din;
  function new(mailbox #(bit [11:0]) mbxds, mailbox #(transaction) mbx);
    this.mbx=mbx;
    this.mbxds=mbxds;
  endfunction
  
  task reset(); 
    vif.rst<=1;
    vif.cs<=1;
    vif.newd<=0;
    vif.din<=0;
    vif.mosi<=0;
    repeat (10) @(posedge vif.clk);
    vif.rst<=0;
    repeat (5) @(posedge vif.clk);
    $display("[DRV]: Reset Done");
    $display("-------------------------------------------------");
  endtask
  
  task run();
    forever begin
      mbx.get(tr);
      @(posedge vif.sclk);
      vif.newd<=1;
      vif.din<=tr.din;
      mbxds.put(tr.din);
      @(posedge vif.sclk);
      vif.newd<=0;
      wait(vif.cs==1);
      $display("[DRV]: Data sent to DAC: %0d", tr.din);
      ->drvnext;
    end
  endtask
endclass


//Monitor class
class monitor;
  transaction tr;
  mailbox #(bit [11:0]) mbx;
  bit [11:0] srx;
  virtual spi_if vif;
  function new(mailbox #(bit [11:0]) mbx);
    this.mbx=mbx;
  endfunction
  
  task run();
    forever begin
      @(posedge vif.sclk);
      wait(vif.cs==0);
      @(posedge vif.sclk);
      for (int i=0; i<=11; i++) begin
        @(posedge vif.sclk);
        srx[i]=vif.mosi;
      end
      wait(vif.cs==1);
      $display("[MON]: Data sent: %0d", srx);
      mbx.put(srx);
    end
  endtask
endclass

//Scoreboard class
class scoreboard;
  mailbox #(bit [11:0]) mbxds, mbxms;
  bit [11:0] ds; 
  bit [11:0] ms;
  event sconext;
  function new(mailbox #(bit [11:0]) mbxds, mailbox #(bit [11:0]) mbxms);
    this.mbxds=mbxds;
    this.mbxms=mbxms;
  endfunction
  
  task run();
    forever begin
      mbxds.get(ds);
      mbxms.get(ms);
      $display("[SCO]: DRV: %0d MON: %0d", ds, ms);
      if(ds==ms) $display("[SCO]: Data Matched");
      else $display("[SCO]: Data Mismatched");
      $display("-------------------------------------------------");
      ->sconext;
    end
  endtask
endclass

//Environment  class
class environment;
  generator gen;
  driver drv;
  monitor mon;
  scoreboard sco;
  event nextgd;
  event nextgs;
  mailbox #(transaction) mbxgd;
  mailbox #(bit [11:0]) mbxds;
  mailbox #(bit [11:0]) mbxms;
  virtual spi_if vif;
  function new(virtual spi_if vif);
    mbxgd=new(); 
    mbxds=new(); 
    mbxms=new();
    gen=new(mbxgd);
    drv=new(mbxds, mbxgd);
    mon=new(mbxms);
    sco=new(mbxds, mbxms);
    this.vif=vif;
    drv.vif=this.vif;
    mon.vif=this.vif;
    gen.sconext=nextgs;
    sco.sconext=nextgs;
    gen.drvnext=nextgd;
    drv.drvnext=nextgd;
  endfunction
  
  task pre_test();
    drv.reset();
  endtask
  
  task test();
    fork 
      gen.run();
      drv.run();
      mon.run();
      sco.run();
    join_any
  endtask
  
  task post_test();
    wait(gen.done.triggered);
    $finish();
  endtask
  
  task run();
    pre_test();
    test();
    post_test();
  endtask
endclass

//testbench
module tb;
  environment env;
  spi_if vif();
  spi dut(vif.clk, vif.newd, vif.rst, vif.din, vif.sclk, vif.cs, vif.mosi);
  initial begin
    vif.clk<=0;
  end
  
  always #10 vif.clk=~vif.clk;
  initial begin
    env=new(vif);
    env.gen.count=20;
    env.run();
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule

  
  

