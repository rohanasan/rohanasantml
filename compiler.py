import sys

res = "<!--Compiled using Rohanasantml compiler -->\n"

args = sys.argv

if(len(args) == 1):
    print("Please enter input and output file")
    sys.exit(1)

if(len(args) == 2):
    print("Please enter output file")
    sys.exit(1)

line_num = 0
starts = 0
ends = 0

with open(args[1], "r") as main_fh:
    full_file_as_list = main_fh.readlines()
    for line in full_file_as_list:
        line_num += 1
        line = line.strip()
        tokens = line.split()
        if len(tokens) >= 1 and tokens[0].startswith("//"):
            # it is a comment
            continue
        elif not tokens:
            # it is an empty line
            continue
        elif len(tokens)>1 and tokens[1] == "end":
            res = res + "</" + tokens[0] + ">" + "\n"
            ends += 1
        elif len(tokens) >= 1 and tokens[0].startswith("{"):
            if line[-1] != "}":
                print(f"Did you forget to end the line {line_num} with '{"}"}' ?")
                sys.exit(1)
            gg = ' '.join(tokens)
            gg = gg.replace("{", "")
            gg = gg.replace("}", "")
            gg += "\n"
            res += gg
        else:
            if len(tokens)>=1 and tokens[-1] == "end":
                tokens.pop()
                res = res + "<" + ' '.join(tokens) + "/>" + "\n"
            else:
                res = res + "<" + ' '.join(tokens) + ">" + "\n"
                starts += 1
    main_fh.close()
with open(args[2], "w") as output:
    output.write(res)
    output.close()

if starts > ends:
    print("Warning: Number of tags starting is greater than the number of tags ending.")
if starts < ends:
    print("Warning: Number of tags ending is greater than the number of starting tags.")

print("Generated " + args[2])
