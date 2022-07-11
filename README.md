# AlertLogic

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

and to use Elixir run
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

## Notes

To run the program based on the specification, there is a bash script called program. This is so the terminal can be used to `cat` the data from the file `input.txt` into program (bash script).

From here the bash script calls the Elixir module which encapsulates the logic for taking a string with tokens
and building a regex based on a basic algorithm that looks at the string values and determines the token type
(standard, greedy, lazy etc). This part of the code has unit tests to verify the creation of the regex works
correctly.

The regex string is outputted from the Elixir module and used with pcre2grep which writes all the correct matches to `output.txt`



