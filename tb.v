`timescale 1ns / 1ps

module bi_shift_reg_tb();

    // Parameters
    parameter N = 4;
    
    // Inputs
    reg clk;
    reg reset;
    reg D;
    reg en;
    reg dir;
    
    // Outputs
    wire [N-1:0] out;
    
    // Instantiate the Unit Under Test (UUT)
    bi_shift_reg #(.N(N)) uut (
        .clk(clk), 
        .reset(reset), 
        .D(D), 
        .en(en), 
        .dir(dir), 
        .out(out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100MHz clock
    end
    
    // Test sequence
    initial begin
        // Initialize Inputs
        reset = 0;
        D = 0;
        en = 0;
        dir = 0;

        // Wait 50 ns for global reset to finish
        #50;
        
        // Release reset
        reset = 1;
        
        // Test 1: Shift right
        en = 1;
        dir = 0;
        D = 1;
        #10;
        D = 0;
        #10;
        D = 1;
        #10;
        D = 1;
        #10;
        
        // Test 2: Hold
        en = 0;
        #20;
        
        // Test 3: Shift left
        en = 1;
        dir = 1;
        D = 0;
        #10;
        D = 1;
        #10;
        D = 0;
        #10;
        D = 0;
        #10;
        
        // Test 4: Reset
        reset = 0;
        #10;
        reset = 1;
        
        // Test 5: Alternate directions
        dir = 0;
        D = 1;
        #10;
        dir = 1;
        D = 0;
        #10;
        dir = 0;
        D = 1;
        #10;
        
        // End simulation
        //#100;
        $finish;
    end
    
    // Monitor changes
    initial begin
        $monitor("Time=%0t reset=%b en=%b dir=%b D=%b out=%b", 
                 $time, reset, en, dir, D, out);
    end

    initial begin 
        $dumpfile("Bi_Shift_dump.vcd");
        $dumpvars(1);
    end
endmodule