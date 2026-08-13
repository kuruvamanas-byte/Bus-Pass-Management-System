`timescale 1ns/1ps

module tb_bus_pass_management;

    reg clk;
    reg reset;

    reg apply;
    reg renew;

    reg [1:0] passenger_type;
    reg [1:0] duration;

    reg [3:0] current_month;
    reg [3:0] validity_month;

    wire [15:0] pass_id;
    wire [15:0] fare;

    wire pass_active;
    wire expired;
    wire valid;

    wire [1:0] status;

    // ------------------------------------------------
    // DUT
    // ------------------------------------------------
    bus_pass_management DUT (

        .clk(clk),
        .reset(reset),

        .apply(apply),
        .renew(renew),

        .passenger_type(passenger_type),
        .duration(duration),

        .current_month(current_month),
        .validity_month(validity_month),

        .pass_id(pass_id),
        .fare(fare),

        .pass_active(pass_active),
        .expired(expired),
        .valid(valid),

        .status(status)
    );

    // ------------------------------------------------
    // Clock generation
    // ------------------------------------------------
    always #5 clk = ~clk;

    // ------------------------------------------------
    // Test sequence
    // ------------------------------------------------
    initial begin

        // Initialize
        clk = 0;
        reset = 1;

        apply = 0;
        renew = 0;

        passenger_type = 2'b00;
        duration = 2'b00;

        current_month = 4'd1;
        validity_month = 4'd2;

        #10;

        // Release reset
        reset = 0;

        // ------------------------------------------------
        // TEST 1
        // Regular passenger - 1 month
        // Expected fare = 500
        // ------------------------------------------------

        passenger_type = 2'b00;
        duration = 2'b00;

        apply = 1;

        #10;

        apply = 0;

        $display("---------------------------------------");
        $display("TEST 1: Regular Passenger");
        $display("Pass ID      = %d", pass_id);
        $display("Fare         = %d", fare);
        $display("Pass Active  = %b", pass_active);
        $display("Status       = %b", status);

        // ------------------------------------------------
        // TEST 2
        // Student - 3 months
        // Expected fare = 600
        // ------------------------------------------------

        #10;

        passenger_type = 2'b01;
        duration = 2'b01;

        apply = 1;

        #10;

        apply = 0;

        $display("---------------------------------------");
        $display("TEST 2: Student Passenger");
        $display("Pass ID      = %d", pass_id);
        $display("Fare         = %d", fare);
        $display("Pass Active  = %b", pass_active);
        $display("Status       = %b", status);

        // ------------------------------------------------
        // TEST 3
        // Senior Citizen - 6 months
        // Expected fare = 1200
        // ------------------------------------------------

        #10;

        passenger_type = 2'b10;
        duration = 2'b10;

        apply = 1;

        #10;

        apply = 0;

        $display("---------------------------------------");
        $display("TEST 3: Senior Citizen");
        $display("Pass ID      = %d", pass_id);
        $display("Fare         = %d", fare);
        $display("Pass Active  = %b", pass_active);
        $display("Status       = %b", status);

        // ------------------------------------------------
        // TEST 4
        // Renewal
        // ------------------------------------------------

        #10;

        passenger_type = 2'b00;
        duration = 2'b01;

        renew = 1;

        #10;

        renew = 0;

        $display("---------------------------------------");
        $display("TEST 4: Pass Renewal");
        $display("Pass ID      = %d", pass_id);
        $display("Fare         = %d", fare);
        $display("Pass Active  = %b", pass_active);
        $display("Status       = %b", status);

        // ------------------------------------------------
        // TEST 5
        // Expiry
        // ------------------------------------------------

        #10;

        current_month = 4'd10;
        validity_month = 4'd5;

        #10;

        $display("---------------------------------------");
        $display("TEST 5: Pass Expiry");
        $display("Pass Active  = %b", pass_active);
        $display("Expired      = %b", expired);
        $display("Status       = %b", status);

        // ------------------------------------------------
        // Finish simulation
        // ------------------------------------------------

        #20;

        $display("---------------------------------------");
        $display("Simulation completed successfully.");
        $display("---------------------------------------");

        $finish;

    end

endmodule
