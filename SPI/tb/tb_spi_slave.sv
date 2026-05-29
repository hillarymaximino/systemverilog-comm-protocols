`timescale 1ns / 1ps
module tb_spi_slave;

    logic tb_sck;
    logic tb_rst;
    logic tb_cs_n;
    logic tb_mosi;
    logic tb_miso;

    logic [7:0] master_shift_reg;
  
    spi_slave dut (
    
        .i_sck   (tb_sck),
        .i_rst   (tb_rst),
        .i_cs_n  (tb_cs_n),
        .i_mosi  (tb_mosi),
        .o_miso  (tb_miso)
    );
  
    initial tb_sck = 0;
    always #5 tb_sck = ~tb_sck;
  
  initial begin 
    
    $dumpfile("tb_spi_slave.vcd");
    $dumpvars(0, tb_spi_slave);

    master_shift_reg = 8'hA5;

    tb_cs_n = 1'b1;
        tb_rst  = 1'b1;
        #10;
        tb_rst = 1'b0;
        #10;

        tb_cs_n = 1'b0;
        for (int i = 7; i >= 0; i--) begin 
            tb_mosi = master_shift_reg[7];
            @(posedge tb_sck); 
            master_shift_reg = {master_shift_reg[6:0], tb_miso};
            @(negedge tb_sck);
        end
        
        tb_cs_n = 1'b1;
        #20;
         $finish;
    end

endmodule
