module bi_shift_reg #(parameter N=4)(
    input clk,reset,
    input D,
    input en,   //enable
    input dir,  //0-->RS 1-->LS
    output reg [N-1:0] out
);

    always@(posedge clk)
        if (!reset)
            out<=0;
        else begin 
            if(en)
                case (dir)
                    0: out<= {out[N-2:0],D};
                    1: out<= {D, out[N-1:1]};
                endcase
            else
                out<=out;
        end
endmodule