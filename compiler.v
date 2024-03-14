import io
import os

fn main() {
	args := os.args.clone()
	mut resulting_html := "<!--Compiled using Rohanasantml compiler -->\n"
	if args.len == 1{
		panic("Enter input and output files")
	}
	if args.len == 2{
		panic("Enter output file")
	}

    file := os.open(args[1]) or {
		panic("File not there")
	};

	mut r := io.new_buffered_reader(reader: file);

	for {
		mut line := r.read_line() or { break }; // get line
		line = line.trim(" "); // remove white space
		mut tokens := line.split(" "); // tokenize
		if line == "" {
			continue; // Its an empty line
		}
		else if line.starts_with("//") {
			continue; // its a comment
		}
		else if line.starts_with("{") {
			resulting_html = resulting_html + line.replace_once("{", "").replace_once("}", "") + "\n";
		}
		else if tokens.len > 1 && tokens[1] == "end" {
		    resulting_html = resulting_html + "</" +  tokens[0] + ">" + "\n";
		}
		else if tokens.len > 0 && tokens[tokens.len - 1] == "end"{
			tokens[tokens.len - 1] = "";
			mut joined := '';
			for token in tokens {
				joined += token + ' ';
			}
			resulting_html = resulting_html + "<" +  joined + "/>" + "\n";
		}
		else {
			resulting_html = resulting_html + "<" +  line + ">" + "\n";
		}
	}
	os.write_file(args[2],resulting_html)!;
}