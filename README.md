# Pattern to regex app

**This application translates a string sequence with tokens (greedy, lazy) into a regex**

## Installation

This application uses nix to encapsulate all necessary packages required to run this program. 
It can be download using: 
```
sh <(curl -L https://nixos.org/nix/install) --daemon
```

To start nix use the command: 
```
nix-shell
``` 

If `nix-shell` isn't recognised, please restart the terminal.

To use Elixir run
```
mix deps.get --all
``` 
and to build the code:
```
mix
```
Finally to run the program use:
```
cat input.txt |  sh program "foo %{0} is a %{1S3}" > output.txt
```

To generate docs run:
```
mix docs
```

## Notes

To run the program based on the specification, there is a bash script called program. This is so the terminal can be used to `cat` the data from the file `input.txt` into program (bash script).

From here the bash script calls the Elixir module which encapsulates the logic for taking a string with tokens
and building a regex based on a basic algorithm that looks at the string values and determines the token type
(standard, greedy, lazy etc). This part of the code has unit tests to verify the creation of the regex works
correctly.

There are token parser files for the different token types. The idea is if there is a new token type, the engineer would follow the same
pattern and create a new <token_type>.ex file.

The regex string is outputted from the Elixir module and used with pcre2grep which writes all the correct matches to `output.txt`

## Improvements

- Can now call program using `cat input.txt | program "foo %{0} is a %{1S3}" > output.txt` because of the use of an alias 
in the nix shell hook.
- Bug fixes with the 3 token types (standard, limited, greedy)
- More unit tests to handle variations of strings with tokens
- Token parser can now handle numbers bigger than single digits.

## Further improvement
I would refactor the code so every possibly permutation is represented as a lookup in the code. This way we could use every possible
combination and generate a regex which filters the dataset correctly.

|     Value     |                   Regex                     |
|---------------|:-------------------------------------------:|
| word          |  (\<word>)                                  |
| space         |  <space_characteer>                         |
| simple token  |  [a-zA-Z0-9_]+                              |
| limited token |  ([a-zA-Z0-9]+[^a-zA-Z0-9]*){1,#{number}}$  |  
| greedy token  |  ([a-zA-Z ]{1,})                            |  

The string `The %{0} brown fox was %{1G} and neither %{2} nor %{3S2}' would translate to:
```
(The) [a-zA-Z0-9_]+ (brown) (fox) (was) ([a-zA-Z ]{1,}).*? (and) (neither) [a-zA-Z0-9_]+ (nor) ([a-zA-Z0-9]+[^a-zA-Z0-9]*){1,3}$ 
```




