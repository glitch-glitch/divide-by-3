module div_by_three (
  input   logic    clk,
  input   logic    reset,

  input   logic    x_i,

  output  logic    div_o

);
  //next_state = (2*remainder of current state + x_i) mod3
  
typedef enum logic [1:0] {
    S0 = 2'b00, 
    S1 = 2'b01, 
    S2 = 2'b10  
  } state_t;

  state_t current_state, next_state;

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= S0; 
    end else begin
      current_state <= next_state;
    end
  end
  
  always_comb begin
    div_o = 1'b0;
    case (current_state)
      S0: begin
        if (x_i) next_state = S1; 
        else    begin next_state = S0; div_o=1'b1; end
      end

      S1: begin
        if (x_i) begin next_state = S0; div_o=1'b1; end
        else     next_state = S2; 
      end

      S2: begin
        if (x_i) next_state = S2;
        else     next_state = S1; 
      end

      default: next_state = S0; 
    endcase
  end
