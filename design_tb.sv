`timescale 1ns/1ps

module tb_div_by_three;
  logic clk;
  logic reset;
  logic x_i;
  logic div_o;

  // Variables for tracking the test
  int error_count = 0;
  logic [31:0] current_value = 0; 

  div_by_three dut (
    .clk(clk),
    .reset(reset),
    .x_i(x_i),
    .div_o(div_o)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end


  initial begin
    reset = 1;
    x_i = 0;
    
    repeat(2) @(posedge clk);
    
    @(negedge clk); 
    reset = 0;
    $display("Starting Simulation");
    check_bit(1, 0); 
    check_bit(1, 1); 
    check_bit(0, 1); 
    check_bit(1, 0); 
    check_bit(0, 0); 
    check_bit(1, 0); 
    check_bit(1, 0); 
    check_bit(1, 0); 
    check_bit(0, 0); 
    if (error_count == 0)
        $display("TEST PASSED: All sequences verified correctly.");
    else
        $display("TEST FAILED: %0d mismatches found.", error_count);
    
    $finish;
  end

  // Task to apply input and verify output
  task check_bit(input logic bit_val, input logic expected_o);
    begin
      // Update our internal shadow register for debug printing
      current_value = (current_value << 1) | bit_val;

      @(negedge clk);
      x_i = bit_val;

      // Wait for combinational logic to settle, check before next clock
      #1; 
      
      // Check result
      if (div_o !== expected_o) begin
        $display("Time %0t [FAIL] Input bit: %b | Total Val: %0d | Exp: %b | Got: %b", 
                 $time, bit_val, current_value, expected_o, div_o);
        error_count++;
      end else begin
        $display("Time %0t [PASS] Input bit: %b | Total Val: %0d | Exp: %b | Got: %b", 
                 $time, bit_val, current_value, expected_o, div_o);
      end
    end
  endtask

endmodule
