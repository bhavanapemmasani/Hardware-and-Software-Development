# Function to generate a SystemVerilog testbench from the template
#print("Checkpoint 1: Script started")
def generate_testbench(module_name, inputs, outputs, test_cases):
    # Define the template
    template = '''
    `timescale 1ns / 1ps

    module {{module_name}}_tb;

        // Declare inputs and outputs
        reg [31:0] {{inputs}};
        wire [31:0] {{outputs}};

        //Instantiate the DUT (Design Under Test)
        {{module_name}} DUT (
            .A({{input_A}}),
            .B({{input_B}}),
            .Op({{operation}}),
            .Result({{result}})
        );

        // Stimulus generation (test cases)
        initial begin
            {{initial_conditions}}
            
            // Apply different test cases
            #10;
            {{test_case_1}};
            #10;
            {{test_case_2}};
            #10;
            $finish;
        end

    endmodule
    '''

    # Replace the placeholders with actual values
    testbench_code = (
        template.replace("{{module_name}}", module_name)
                .replace("{{inputs}}", ', '.join(inputs))
                .replace("{{outputs}}", ', '.join(outputs))
                .replace("{{input_A}}", inputs[0])
                .replace("{{input_B}}", inputs[1])
                .replace("{{operation}}", inputs[2])  # Assuming Op is the operation input
                .replace("{{result}}", outputs[0])  # Assuming result is the output
                .replace("{{initial_conditions}}", "A = 0; B = 0; Op = 0;")  # Initial conditions
                .replace("{{test_case_1}}", test_cases[0])
                .replace("{{test_case_2}}", test_cases[1])
    )

    return testbench_code

# Example usage
module_name = "ALU"
inputs = ["A", "B", "Op"]
outputs = ["Result"]
test_cases = ["A = 10; B = 5; Op = 2;", "A = 15; B = 10; Op = 1;"]

# Generate the testbench
testbench_code = generate_testbench(module_name, inputs, outputs, test_cases)
print("Script executed successfully!")
print(testbench_code)
#print("Checkpoint 2: Before file write")
# Save to file
with open("ALU_tb.sv", "w") as f:
    f.write(testbench_code)

#print("Script executed successfully!")
