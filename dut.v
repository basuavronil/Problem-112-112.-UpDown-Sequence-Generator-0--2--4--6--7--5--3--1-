module abc(
  input  clk, rst, en,
  output reg [2:0] out
);
  localparam S0 = 3'd0, S1 = 3'd2, S2 = 3'd4, S3 = 3'd6,
             S4 = 3'd7, S5 = 3'd5, S6 = 3'd3, S7 = 3'd1;

  reg [2:0] p_state, n_state;

  always @(posedge clk or negedge rst) begin
    if (!rst) p_state <= S0;
    else      p_state <= n_state;
  end

  always @(*) begin
    n_state = p_state;      // defaults: no latches
    out     = 3'd0;
    if (en) begin
      case (p_state)
        S0: n_state = S1;
        S1: n_state = S2;
        S2: n_state = S3;
        S3: n_state = S4;
        S4: n_state = S5;
        S5: n_state = S6;
        S6: n_state = S7;
        S7: n_state = S0;
        default: n_state = S0;
      endcase
    end
    else begin
      out = p_state;        // en = 0: show current state
    end
  end
endmodule
