module abc(
  input  clk, rst, en,
  output reg out
);
  localparam S0 = 3'd0;
  localparam S1 = 3'd2;
  localparam S2 = 3'd4;
  localparam S3 = 3'd6;
  localparam S4 = 3'd7;
  localparam S5 = 3'd5;
  localparam S6 = 3'd3;
  localparam S7 = 3'd1;

  reg [2:0] p_state, n_state;

  // State register
  always @(posedge clk or negedge rst) begin
    if (!rst)
      p_state <= S0;
    else
      p_state <= n_state;
  end

  // Next-state logic
  always @(*) begin
    n_state = p_state;          // default: hold
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
  end

  // Output logic (Moore)
  always @(*) begin
    out = p_state[0];
  end
endmodule
