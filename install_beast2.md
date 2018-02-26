# Install BEAST2

## GNU/Linux:

BEAST2 (version 2.4.7) can be installed from R:

```
library(beastier)
install_beast2()
```

This will download and extract BEAST2 to the folder `~/Programs/beast`. 
`beast.jar` is found at `~/Programs/beast/lib/beast.jar`.

## Windows

 * Download a Windows release with version 2.4.7 
   from [https://github.com/CompEvol/beast2/releases/tag/v2.4.7](https://github.com/CompEvol/beast2/releases/tag/v2.4.7).
 * Unzip the file somewhere
 * Specify the path to `beast.jar` when calling `run_beast2`:

```
library(beastier)
run_beast2(
  input_filename = get_path("2_4.xml"),
  beast2_jar_path = "X:/path/to/lib/beast.jar"
)
```
