module mux2_1
    #(parameter width = 16)
    (input logic [width-1:0] d0, d1,
    input logic s,
    output logic [width-1:0] out);
    always_comb begin
        if (s)
            out = d1;
        else
            out = d0;
    end
endmodule

module mux4_1
    #(parameter width = 16)(
    input logic [width-1:0] d0, d1, d2, d3,
    input logic [1:0] s,
    output logic [width-1:0] out);
    always_comb begin
        unique case(s)
        2'b00:
            out=d0;
        2'b01:
            out=d1;
        2'b10:
            out=d2;
        2'b11:
            out=d3;
        endcase
    end
endmodule
