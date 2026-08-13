`timescale 1ns/1ps

module bus_pass_management (
    input  wire        clk,
    input  wire        reset,

    input  wire        apply,
    input  wire        renew,

    input  wire [1:0]  passenger_type,
    input  wire [1:0]  duration,

    input  wire [3:0]  current_month,
    input  wire [3:0]  validity_month,

    output reg  [15:0] pass_id,
    output reg  [15:0] fare,

    output reg         pass_active,
    output reg         expired,
    output reg         valid,

    output reg  [1:0]  status
);

    // Passenger types
    localparam REGULAR = 2'b00;
    localparam STUDENT = 2'b01;
    localparam SENIOR  = 2'b10;

    // Duration
    localparam ONE_MONTH   = 2'b00;
    localparam THREE_MONTH = 2'b01;
    localparam SIX_MONTH   = 2'b10;

    // Status
    localparam IDLE    = 2'b00;
    localparam ACTIVE  = 2'b01;
    localparam EXPIRED = 2'b10;
    localparam INVALID = 2'b11;

    reg [15:0] base_fare;
    reg [15:0] calculated_fare;

    // ------------------------------------------------
    // Fare calculation
    // ------------------------------------------------
    always @(*) begin

        // Determine base fare
        case (duration)

            ONE_MONTH:
                base_fare = 16'd500;

            THREE_MONTH:
                base_fare = 16'd1200;

            SIX_MONTH:
                base_fare = 16'd2000;

            default:
                base_fare = 16'd0;

        endcase

        // Apply passenger discount
        case (passenger_type)

            REGULAR:
                calculated_fare = base_fare;

            STUDENT:
                calculated_fare = base_fare / 2;

            SENIOR:
                calculated_fare = (base_fare * 6) / 10;

            default:
                calculated_fare = 16'd0;

        endcase
    end

    // ------------------------------------------------
    // Pass management
    // ------------------------------------------------
    always @(posedge clk or posedge reset) begin

        if (reset) begin

            pass_id     <= 16'd0;
            fare        <= 16'd0;
            pass_active <= 1'b0;
            expired     <= 1'b0;
            valid       <= 1'b0;
            status      <= IDLE;

        end

        else begin

            // Check expiry
            if (pass_active && (current_month > validity_month)) begin

                expired     <= 1'b1;
                pass_active <= 1'b0;
                status      <= EXPIRED;

            end

            // New pass application
            if (apply) begin

                if ((passenger_type <= SENIOR) &&
                    (duration <= SIX_MONTH)) begin

                    pass_id     <= pass_id + 16'd1;
                    fare        <= calculated_fare;
                    pass_active <= 1'b1;
                    expired     <= 1'b0;
                    valid       <= 1'b1;
                    status      <= ACTIVE;

                end

                else begin

                    valid  <= 1'b0;
                    status <= INVALID;

                end
            end

            // Pass renewal
            else if (renew) begin

                if ((passenger_type <= SENIOR) &&
                    (duration <= SIX_MONTH)) begin

                    pass_id     <= pass_id + 16'd1;
                    fare        <= calculated_fare;
                    pass_active <= 1'b1;
                    expired     <= 1'b0;
                    valid       <= 1'b1;
                    status      <= ACTIVE;

                end

                else begin

                    valid  <= 1'b0;
                    status <= INVALID;

                end
            end

        end
    end

endmodule
