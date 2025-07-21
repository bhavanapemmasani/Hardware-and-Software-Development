//Transaction Class
class transaction;
  rand bit in;
  bit seq;
  
  function transaction copy();
    copy=new();
    copy.in=this.in;
    copy.seq=this.seq;
  endfunction
  
  function void display(string tag);
    $display("[%s] in: %0b, seq: %0b", tag, in, seq);
  endfunction
    
endclass

//Generator Class
class generator;
  transaction tr;
  mailbox #(transaction) mbx;
  event done;
  event drvnext;
  event sconext;
  int count=0;
  
  function new(mailbox #(transaction) mbx);
    this.mbx=mbx;
    tr=new();
  endfunction
  
  task run();
    repeat (count) begin
      assert(tr.randomize) else $error("randomization failed");
      mbx.put(tr.copy());
      @(drvnext);
      @(sconext);
    end
    ->done;
  endtask
endclass


//Driver Class
class driver;
  virtual sequence_if vsf;
  transaction tr;
  mailbox #(transaction) mbx;
  mailbox #(bit) mbxds;
  event drvnext;
  bit in;
  
  function new(mailbox #(bit) mbxds, mailbox #(transaction) mbx);
    this.mbx=mbx;
    this.mbxds=mbxds;
  endfunction
  
  task reset();
  vsf.rst <= 1;
  vsf.in  <= 0;
  repeat(10) @(posedge vsf.clk);
  vsf.rst <= 0;
  repeat(5) @(posedge vsf.clk);
  $display("DRV: Reset Done!");
endtask

  
  task run();
    forever begin
      mbx.get(tr);
      @(posedge vsf.clk);
      vsf.in<=tr.in;
      mbxds.put(tr.in);
      $display("DRV:Sent %0b", tr.in);
      ->drvnext;
    end
      
  endtask
endclass

//Monitor Class
class monitor;
  transaction tr;
  mailbox #(bit) mbx;
  bit sample;
  virtual sequence_if vsf;
  mailbox #(transaction) mbxms;
  
  function new (mailbox #(transaction) mbxms, mailbox #(bit) mbx);
    this.mbxms=mbxms;
    this.mbx=mbx;
  endfunction
  
  task run();
    forever begin
      @(posedge vsf.clk);
      tr=new();
      mbx.get(sample);
      tr.in=sample;
      tr.seq=vsf.seq;
      mbxms.put(tr.copy());
      tr.display("MON");
      
    end
    
  endtask
endclass


//Scoreboard Class

class scoreboard;
  mailbox #(transaction) mbxms;
  event sconext;
  logic [5:0] check = 0; 

  function new(mailbox #(transaction) mbxms);
    this.mbxms = mbxms;
  endfunction

  task run();
    transaction tr;
    logic reference;
    forever begin
      mbxms.get(tr);
      check = {check[4:0], tr.in}; // shift in new bit

      reference = (check == 6'b101101); 

      if (tr.seq != reference)
        $display("SCO MISMATCH");
      else
        $display("SCO MATCHED");

      ->sconext;
    end
  endtask
endclass


//Test Class
class test;
  generator g;
  driver d;
  monitor m;
  scoreboard s;
  task pre_test();
    d.reset();
  endtask
  
  task test();
    fork 
      g.run();
      d.run();
      m.run();
      s.run();
    join_any
    
  endtask
  
  task post_test();
    wait(g.done.triggered);
    $finish();    
  endtask
  
  task run();
    pre_test();
    test();
    post_test();
  endtask
  
endclass

//Environment Class
class environment;
  test t;
  generator g;
  driver d;
  monitor m;
  scoreboard s;
  mailbox #(transaction) mbxgd, mbxms;
  mailbox #(bit) mbxds;
  event nextgd, nextgs;
  virtual sequence_if vsf;
  
  function new(virtual sequence_if vsf);
    mbxgd = new(); 
    mbxms = new();
    mbxds = new();
    g = new(mbxgd);
    d = new(mbxds, mbxgd);
    m = new(mbxms, mbxds);
    s = new(mbxms);
    this.vsf = vsf;
    d.vsf = this.vsf;
    m.vsf = this.vsf;
    g.sconext = nextgs;
    s.sconext = nextgs;
    g.drvnext = nextgd;
    d.drvnext = nextgd;
  endfunction

  function void connect();
    t.g = g;
    t.d = d;
    t.m = m;
    t.s = s;
  endfunction

  task run();
    t = new();
    connect();  
    t.run();
  endtask
endclass


//Module Testbench top
module tb;
  environment e;
  sequence_if vsf();
  sequence_detector dut (.clk(vsf.clk),.rst(vsf.rst),.in(vsf.in),.seq(vsf.seq));
  
  initial vsf.clk=0;
  always #5 vsf.clk=~vsf.clk;
  
  initial begin
    e=new(vsf);
    e.g.count=50;
    e.run();
    
  end
 
endmodule