//Transaction
class transaction;
  rand bit oper;
  bit rd, wr;
  bit [7:0] data_in;
  bit full, empty;
  bit [7:0] data_out;
  
  constraint oper_cntrl {
    oper dist{1:/50, 0:/50 };
  }
  
endclass

//Generator
class generator;
  transaction tr;
  mailbox #(transaction) mbx;
  
  int count=0; int i=0;
  event done, next;
  
  function new(mailbox #(transaction) mbx);
    this.mbx=mbx;
    tr=new();
  endfunction
  
  task run();
    repeat(count) begin
      assert(tr.randomize) else $error("Randomization Failed");
      i++;
      mbx.put(tr);
      $display("[GEN]: oper %0d iteration %0d", tr.oper, i);
      @(next);
    end
    ->done;
  endtask
endclass

//Driver
class driver;
  virtual fifo_if fif;
  mailbox #(transaction) mbx;
  transaction datac;
  event next;
  
  function new(mailbox #(transaction) mbx);
    this.mbx=mbx;
  endfunction
  
  //Reset DUT
  task reset();
    fif.rst<=1'b1;
    fif.rd<=0;
    fif.wr<=0;
    fif.data_in<=0;
    repeat (5) @(posedge fif.clock);
    fif.rst<=0;
    $display("[DRV]: Reset Done");
    $display("-------------------------------------------------");
  endtask
  
  task write();
    @(posedge fif.clock);
    fif.rst<=0;
    fif.rd<=0;
    fif.wr<=1;
    fif.data_in<=$urandom_range(1,10);
    fif.wr<=0;
    $display("[DRV]: Data Write: %0d", fif.data_in);
    @(posedge fif.clock);
  endtask
  
  task read();
    @(posedge fif.clock);
    fif.rst<=0;
    fif.rd<=1;
    fif.wr<=0;
    @(posedge fif.clock);
    fif.rd<=0;
    $display("[DRV]:Data Read");
    @(posedge fif.clock);
  endtask
  
  //Applying random stimulus to DUT
  task run();
    forever begin
      mbx.get(datac);
      if(datac.oper==1)
        write();
      else read();
    end
  endtask
endclass

//Monitor
class monitor;
  virtual fifo_if fif;
  mailbox #(transaction) mbx;
  transaction tr;
  function new(mailbox #(transaction) mbx);
    this.mbx=mbx;
  endfunction
  
  task run();
    tr=new();
    forever begin 
      repeat(2) @(posedge fif.clock);
      tr.wr<=fif.wr;
      tr.rd<=fif.rd;
      tr.data_in<=fif.data_in;
      tr.full<=fif.full;
      tr.empty<=fif.empty;
      @(posedge fif.clock);
      tr.data_out<=fif.data_out;
      mbx.put(tr);
      $display("[MON]:wr: %0d rd: %0d din: %0d dout: %0d full: %0d empty: %0d ", tr.wr, tr.rd, tr.data_in, tr.data_out, tr.full, tr.empty);
    end
  endtask
endclass


//Scoreboard
class scoreboard;
  mailbox #(transaction) mbx;
  transaction tr;
  event next;
  bit [7:0] din[$];
  bit [7:0] temp;
  
  int err=0;
  
  function new(mailbox #(transaction) mbx);
    this.mbx=mbx;
  endfunction
  
  task run();
    forever begin
      mbx.get(tr);
      $display("[SCO]:wr: %0d rd: %0d din: %0d dout: %0d full: %0d empty: %0d ", tr.wr, tr.rd, tr.data_in, tr.data_out, tr.full, tr.empty);
      
      if(tr.wr==1) begin
        if(tr.full==0) begin
          din.push_front(tr.data_in);
          $display("[SCO]: Data stored in queue: %0d", tr.data_in);
        end
        else
          begin
            $display("[SCO]: FIFO is full");
          end
        $display("------------------------------------------------");
      end
      if(tr.rd==1) begin
        if(tr.empty==0) begin
          temp=din.pop_back();
          if(tr.data_out==temp) $display("[SCO]: Data Matched");
          else begin
            $error("[SCO]: Data Mismatched");
            err++;
          end
        end
        else begin
          $display("[SCO]: FIFO is empty");
        end
        $display("------------------------------------------------");
      end
      ->next;
    end
  endtask
endclass      

//Environment
class environment;
  generator gen;
  driver drv;
  scoreboard sco;
  monitor mon;
  mailbox #(transaction) gdmbx;
  mailbox #(transaction) msmbx;
  event nextgs;
  virtual fifo_if fif;
  function new(virtual fifo_if fif);
    gdmbx=new();
    msmbx=new();
    gen=new(gdmbx);
    drv=new(gdmbx);
    mon=new(msmbx);
    sco=new(msmbx);
    this.fif=fif;
    drv.fif=this.fif;
    mon.fif=this.fif;
    gen.next=nextgs;
    sco.next=nextgs;
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
    $display("------------------------------------------------");
    $display("Error count: %0d", sco.err);
    $display("------------------------------------------------");
    $finish;
  endtask
  
  task run();
    pre_test();
    test();
    post_test();
  endtask
endclass       

//Testbench Top

module tb;
  fifo_if fif();
  FIFO DUT(fif.clock, fif.rst,fif.wr, fif.rd, fif.data_in, fif.data_out, fif.empty, fif.full);
  initial begin
    fif.clock<=0;
  end
  always #10 fif.clock<=~fif.clock;
  
  environment env;
  initial begin 
    env=new(fif);
    env.gen.count=30;
    env.run();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule

  
  