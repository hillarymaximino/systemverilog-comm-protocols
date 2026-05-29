module spi_slave (

    input logic i_sck, 
    input logic i_rst,
    input logic i_cs_n,
    input logic i_mosi,
    output logic o_miso

); 

logic [7:0] r_shift_reg;
logic r_tx_bit;

assign o_miso = (ci_cs_n == 1'b0) ? r_tx_bit : 1'bz;

always_ff @(posedge i_sck or posedge i_rst) begin

    if(i_rst) begin 
        r_shift_reg <= '0;
        r_tx_bit <= 0;
    end

    else begin
        if (i_cs_n == 1'b0) begin 
            r_tx_bit <= r_shift_reg[7];
            r_shift_reg <= {r_shift_reg[6:0], i_mosi};
        end
    end
    
end

endmodule
