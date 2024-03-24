use std::env;
use std::fs::File;
use std::io::{BufRead, BufReader, Write};
use std::process;

fn main() {
    let args: Vec<String> = env::args().collect();
    let mut resulting_html = "<!--Compiled using Rohanasantml compiler -->\n".to_string();
    if args.len() == 1 {
        println!("Error: Please enter input and output file paths.");
        process::exit(1);
    }
    if args.len() == 2 {
        println!("Error: Please enter output file path.");
        process::exit(1);
    }

    let file = File::open(&args[1]).unwrap_or_else(|_| {
        println!("Error: Please enter valid file path.");
        process::exit(1);
    });

    let mut reader = BufReader::new(file);

    let mut line_count = 0;
    let mut started = 0; // Count the number of tags that are starting
    let mut ended = 0; // Count the number of tags that are ending

    loop {
        line_count += 1;
        let mut line = String::new();
        let bytes_read = reader.read_line(&mut line).expect("Failed to read line");
        if bytes_read == 0 {
            break;
        }
        line = line.trim().to_string(); // remove white space
        let tokens: Vec<&str> = line.split_whitespace().collect(); // tokenize
        if line.is_empty() {
            continue; // Its an empty line
        } else if line.starts_with("//") {
            continue; // its a comment
        } else if line.starts_with("{") {
            if !line.ends_with("}") {
                println!(
                    "Error: Did you forget to end the line {} with a '}}' ?",
                    line_count
                );
                process::exit(1);
            }
            resulting_html += &(line.replace("{", "").replace("}", "") + "\n");
        } else if tokens.len() > 1 && tokens[1] == "end" {
            resulting_html += &format!("</{}>\n", tokens[0]);
            ended += 1;
        } else if tokens.len() > 0 && tokens[tokens.len() - 1] == "end" {
            let mut joined = String::new();
            for token in &tokens[..tokens.len() - 1] {
                joined += &format!("{} ", token);
            }
            resulting_html += &format!("<{}/>\n", joined.trim());
        } else {
            resulting_html += &format!("<{}>\n", line);
            started += 1;
        }
    }

    let mut output_file = File::create(&args[2]).unwrap_or_else(|_| {
        println!("Error: Please enter a valid output file path.");
        process::exit(1);
    });
    output_file
        .write_all(resulting_html.as_bytes())
        .expect("Failed to write to file");

    if started > ended {
        println!("Warning: Number of tags you created don't have their corresponding ending tags!");
    }
    if started < ended {
        println!("Warning: Number of ending tags are greater than the number of starting tags.");
    }

    println!("Generated {}", args[2]);
}
