
🚌 Bus Pass Management System
1. Project Overview

The Bus Pass Management System is a digital system designed to manage bus-pass applications, fare calculation, pass validity, renewal, and expiry status.

This project is implemented using Verilog HDL and can be simulated using tools such as ModelSim, QuestaSim, Vivado, or Icarus Verilog.

The system accepts passenger information such as passenger type, pass duration, and renewal request. Based on these inputs, it calculates the corresponding pass fee and generates the current pass status.

2. Objectives

The main objectives of this project are:

To design a digital bus-pass management system.
To calculate bus-pass fees automatically.
To support different passenger categories.
To generate a unique pass ID.
To maintain pass validity.
To support pass renewal.
To detect expired passes.
To demonstrate the design using Verilog HDL simulation.
3. Passenger Types

The system supports three passenger categories:

Passenger Type	Description	Discount
00	Regular Passenger	0%
01	Student	50%
10	Senior Citizen	40%
4. Pass Duration

The following pass durations are supported:

Duration	Base Fare
1 Month	₹500
3 Months	₹1200
6 Months	₹2000

The final fare is calculated according to the passenger category.

Example

For a student applying for a 3-month pass:

Base Fare = ₹1200

Student Discount = 50%

Final Fare = ₹600

5. System Inputs
Signal	Width	Description
clk	1 bit	System clock
reset	1 bit	Active-high reset
apply	1 bit	Apply for a new pass
renew	1 bit	Renew an existing pass
passenger_type	2 bits	Passenger category
duration	2 bits	Pass duration
current_month	4 bits	Current month
validity_month	4 bits	Pass expiry month
6. System Outputs
Signal	Width	Description
pass_id	16 bits	Generated pass ID
fare	16 bits	Calculated fare
pass_active	1 bit	Indicates active pass
expired	1 bit	Indicates expired pass
valid	1 bit	Indicates valid transaction
status	2 bits	Current pass status
Status Encoding
00 = IDLE
01 = ACTIVE
10 = EXPIRED
11 = INVALID

7. Block Diagram
             +----------------------+
             |    User Inputs       |
             |----------------------|
             | Passenger Type       |
             | Pass Duration        |
             | Apply / Renew        |
             | Current Month        |
             +----------+-----------+
                        |
                        v
             +----------------------+
             | Fare Calculation     |
             | Unit                 |
             +----------+-----------+
                        |
                        v
             +----------------------+
             | Pass Management      |
             | Controller           |
             +----------+-----------+
                        |
              +---------+---------+
              |                   |
              v                   v
       +-------------+     +-------------+
       | Pass ID     |     | Pass Status |
       | Generator   |     | Controller  |
       +-------------+     +-------------+
              |                   |
              +---------+---------+
                        |
                        v
             +----------------------+
             | System Outputs       |
             | Fare / ID / Status   |
             +----------------------+

8. Working Principle
Step 1: Apply for Pass

When apply = 1, the system accepts the passenger type and duration.

Step 2: Calculate Fare

The system determines the base fare from the selected duration and applies the appropriate discount.

Step 3: Generate Pass ID

A new pass ID is generated whenever a valid application is submitted.

Step 4: Activate Pass

After successful application, pass_active becomes 1.

Step 5: Check Validity

The system compares the current month with the pass validity month.

If the current month is greater than the validity month, the pass is marked as expired.

Step 6: Renewal

When renew = 1, the existing pass can be renewed with a new duration and validity period.

9. Example

Suppose:

Passenger Type = Student
Duration       = 3 Months
Apply          = 1


The system calculates:

Base Fare      = ₹1200
Student Rate   = 50%
Final Fare     = ₹600
Pass Status    = ACTIVE

10. Simulation

The testbench verifies:

Reset operation
Regular passenger application
Student passenger application
Senior citizen application
Different pass durations
Pass renewal
Pass expiry
Invalid passenger type

Expected waveform signals include:

clk
reset
apply
renew
passenger_type
duration
fare
pass_id
pass_active
expired
status

11. Tools Required

The project can be simulated using:

ModelSim / QuestaSim
Xilinx Vivado
Icarus Verilog
GTKWave
12. Future Enhancements

The project can be extended with:

RFID-based bus-pass verification
QR-code pass generation
LCD display
Smart-card interface
Online payment integration
Passenger database
FPGA implementation
Automatic expiry notifications
13. Conclusion

The Bus Pass Management System demonstrates how Verilog HDL can be used to design a simple digital management system. The design performs fare calculation, pass generation, validity checking, renewal, and expiry detection.

The project provides a foundation for developing a more advanced smart transportation management system.

14. Author

Bus Pass Management System

Developed as an academic Verilog HDL project.