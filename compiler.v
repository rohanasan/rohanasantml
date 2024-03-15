import io
import os

fn main() {
	args := os.args.clone();
	mut resulting_html := "<!--Compiled using Rohanasantml compiler -->\n";
	if args.len == 1{
		println("Error: Please enter input and output file paths.");
		exit(1);
	}
	if args.len == 2{
		println("Error: Please enter output file path.");
		exit(1);
	}

    file := os.open(args[1]) or {
		println("Error: Please enter valid file path.");
		exit(1)
	};

	mut r := io.new_buffered_reader(reader: file);

	mut line_count := 0;

	mut started := 0; // Count the number of tags that are starting
	mut ended := 0; // Count the number of tags that are ending

	for {
		line_count = line_count + 1;
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
			if !line.ends_with("}") {
				println("Error: Did you forget to end the line "+ line_count.str() +  " with a '}' ?");
				exit(1);
			}
			resulting_html = resulting_html + line.replace_once("{", "").replace_once("}", "") + "\n";
		}
		else if tokens.len > 1 && tokens[1] == "end" {
		    resulting_html = resulting_html + "</" +  tokens[0] + ">" + "\n";
			ended += 1;
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
			started += 1;
		}
	}
	os.write_file(args[2],resulting_html) or {
		println("Error: Please enter a valid output file path.");
		exit(1);
	};

	if started > ended {
		println("Warning: Number of tags the you created don't have their corresponding ending tags!");
	}
	if started < ended {
		println("Warning: Number of ending tags are greater than the number of starting tags.");
	}

	println("Generated " + args[2]);
}
