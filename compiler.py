import sys

res = "<!--Compiled using Rohanasantml compiler -->\n"

args = sys.argv

if(len(args) == 1):
    raise IndexError("Please enter input and output file")

if(len(args) == 2):
    raise IndexError("Please enter output file")

with open(args[1], "r") as main_fh:
    full_file_as_list = main_fh.readlines()
    for line in full_file_as_list:
        tokens = line.strip().split()
        if len(tokens) >= 1 and tokens[0].startswith("//"):
            # it is a comment
            continue
        elif not tokens:
            # it is an empty line
            continue
        elif len(tokens)>1 and tokens[1] == "end":
            res = res + "</" + tokens[0] + ">" + "\n"
        elif len(tokens) >= 1 and tokens[0].startswith("{"):
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
    main_fh.close()
with open(args[2], "w") as output:
    output.write(res)
    output.close()