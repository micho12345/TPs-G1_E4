import math

def generate_memory():
    max_address = 10000
    max_value = 2047
    sine_wave = [int((max_value * math.sin(math.pi * i / (max_address - 1)))) for i in range(max_address)]
    
    with open("memory.v", "w") as f:
        f.write("module memory (\n")
        f.write("    input [13:0] addr1,\n")
        f.write("    input [13:0] addr2,\n")
        f.write("    input [13:0] addr3,\n")
        f.write("    output reg [11:0] data1,\n")
        f.write("    output reg [11:0] data2,\n")
        f.write("    output reg [11:0] data3\n")
        f.write(");\n\n")
        
        f.write("    reg [11:0] mem [0:9999];\n\n")
        
        f.write("    initial begin\n")
        for addr in range(max_address):
            f.write(f"        mem[{addr}] = 12'b{sine_wave[addr]:012b};\n")
        f.write("    end\n\n")
        
        f.write("    always @(*) begin\n")
        f.write("        data1 = mem[addr1];\n")
        f.write("        data2 = mem[addr2];\n")
        f.write("        data3 = mem[addr3];\n")
        f.write("    end\n")
        f.write("endmodule\n")

generate_memory()
