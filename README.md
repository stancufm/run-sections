# Function split your script in parts ( sections )
## 1. Usage - General
##### Source it , call it
Copy the function to the beginning of your script or simply just download it and source the file:
`source run_sections_fn.sh`

Call the function at the beginning of your script with:`fn_run_sections` but after you load `fn_main_args $@`
## 2. Usage - Run just a section from your script
**Example:**
```bash
#!/bin/bash

source main_args_fn.sh
source run_sections_fn.sh

# Load script's arguments into vars
fn_main_args $@

# Parse entire script for sections
fn_run_sections

#:start:section1:
echo "Here is section 1"
#:end:section1:

#:start:section2:
echo "Here is section 2"
#:end:section2:
```
Run your script with argument section and specify what section would you like to run
`./script --section section1`

**Output:** *Here is section1*

## 3. Usage - Run multiple section from your script
**Example:**
```bash
#!/bin/bash

source main_args_fn.sh
source run_sections_fn.sh

# Load script's arguments into vars
fn_main_args $@

# Parse entire script for sections
fn_run_sections

#:start:section1:
echo "Here is section 1"
#:end:section1:

#:start:section2:
echo "Here is section 2"
#:end:section2:

#:start:section3:
echo "Here is section 3"
#:end:section3:

```
Run your script with argument section and specify what section would you like to run
`./script --section section1 section3`

**Output:** 

*Here is section1*

*Here is section3*

## 4. Usage - Run script as it is
**Description:** 
If you just want to run the script as it is, with all line from start to end of the script, just call the script with `--section all` and all your section markers will be ignored ( section marker - `"#:start:section_name:"` , `"#:end:section_name:"` )

Run your script with argument section and specify "all" instead of a section name
`./script --section all`

## 5. Usage - INIT Section
**Description:** 
If you have section that you need to run no matter what, like the first part of your script where you hold the Variables and Constants used in all sections, then mark this as an INIT section with `#:start:INIT:` and finish the sections with `#:end:INIT:` ;
You can mark as many times as you need the INIT section, and the code from this section will run before your any other sections, even if the INIT section is at the end of your script!

**Example:**
```bash
#!/bin/bash

source main_args_fn.sh
source run_sections_fn.sh

# Load script's arguments into vars
fn_main_args $@

# Parse entire script for sections
fn_run_sections

#:start:INIT:
echo "Here is first INIT section!"
#:end:INIT:

#:start:section1:
echo "Here is section 1"
#:end:section1:

#:start:section2:
echo "Here is section 2"
#:end:section2:

#:start:INIT:
echo "Here is second INIT section!"
#:end:INIT:

#:start:section3:
echo "Here is section 3"
#:end:section3:

```
Run your script with argument section and specify what section would you like to run
`./script --section section1 section3`

**Output:** 

*Here is first INIT section!*

*Here is second INIT section!*

*Here is section1*

*Here is section3*

Be careful that if you run `--section all` then the output will be:

**Output:** 

*Here is first INIT section!*

*Here is section1*

*Here is section2*

*Here is second INIT section!*

*Here is section3*

This because the function will ignore any section marks and will run the script from the begging to end

##### Helpful Tip
You can call the script with no argument and at the of the output provided with "USAGE" stuff you will see all sections that are found in your script

## Dependencies 
Use this function in conjunction with `fn_main_args` which will add the functionality to parse your script arguments.

You can download from here [main_args_fn.sh](http://laravel.butonel.ro:8888/P6EPPM-OOTB/p6eppm-installer/snippets/4) ; Call the function with `fn_main_args $@`


# Function for scripts arguments
# main_args_fn.sh ( fn_main_args )
## Usage
##### Source it , call it
Copy the function to the beginning of your script or simply just download it and source the file:
`source main_args_fn.sh`

Call the function at the beginning of your script with:`fn_main_args $@`

##### More details
When you'll run the script with arguments like `./script_name.sh --argument1 value_of_argument1 --argument2 value2`
 the function will simply set a var named "argument1" and the value for var will be "value_of_argument1"
basic it will do `argument1="value_of_argument1"` and you can use the var in your script.

If you want more values to be set for the same argument:

`./script_name.sh --argument1 value1 value2 --argument2 value3`

then you'll have:
- argument1="value1 value2"
- argument2="value3"

##### Helpful Tip
You can use this function in conjunction with `fn_run_sections` which will add the functionality for you to run sections from you script
