# Rohanasantml: An alternative to html

An easy way to write your messy html code in a better way:

```rohanasantml
html

head
    title
        {Rohanasantml}
    title end
head end

body
    div style="color:blue;"
        h1
            {Hello, How are you?}
        h1 end
    div end
body end

html end
```

Compiled:

```ht
<html>
<head>
<title>
Rohanasantml
</title>
</head>
<body>
<div style="color:blue;">
<h1>
Hello, How are you?
</h1>
</div>
</body>
</html>
```

# How to make a rohanasantml project?

## If you have python installed:

- Download compiler.py.
- Place compiler.py at your desired location.
- run:

```sh
python3 ./compiler.py ./your_input_file.rohanasantml ./your_output_file.html
```

## If you have Vlang installed:

```sh
v run ./compiler.v ./your_input_file.rohanasantml ./your_output_file.html
```

# Which one to use? V or Python?

- V is recommend for performing compilation of huge rohanasantml files in milliseconds.
- Python is recommended for .....

# Features:
- Helps code readibility
- Gives you errors of mistakes that you might have made in your code. Such as:
    - Did you forget to add a } at the end of line 15?
    - Warning: Number of tags starting is greater than the number of tags ending.
    - Warning: Number of tags ending is greater than the number of starting tags.
- Helps make reliable html

## Checkout
### Rohanasan: An extremely fast backend framework:
https://github.com/rohanasan/rohanasan

### Join discord:
https://discord.gg/Yg2A3mEret

### Todo:
- Add hot reload and a live server
- Add js support
- Add css support

## Contribution:

https://www.buymeacoffee.com/rohanvashisht

