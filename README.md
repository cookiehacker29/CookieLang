# CookieLang

<center><img src="https://raw.githubusercontent.com/erwanaubry/CookieLang/main/img/logo.png" alt="drawing" width="500"/></center>

**_Status_**

name | statuts
:-: | :-:
**Build** | [![Build Status](https://travis-ci.org/erwanaubry/CookieLang.svg?branch=main)](https://travis-ci.org/erwanaubry/CookieLang)
**Maintainability** | [![Maintainability](https://api.codeclimate.com/v1/badges/c4304dfcf9aa19c69770/maintainability)](https://codeclimate.com/github/erwanaubry/CookieLang/maintainability)
**Coverage** | [![Test Coverage](https://api.codeclimate.com/v1/badges/c4304dfcf9aa19c69770/test_coverage)](https://codeclimate.com/github/erwanaubry/CookieLang/test_coverage)

**_home_**

<https://github.com/erwanaubry/CookieLang>

**_rdoc_**

<https://ruby.github.io/rdoc>

**_bugs_**

<https://github.com/erwanaubry/CookieLang/issues>

## Description

Project purpose by the ENSTA-Bretagne school during my first degrees of Master in Cybersecurity. The objective is create a compiler for anything we want. I had choice to create a compiler for a new language, the CookieLang.

The compiler will be created in Ruby for rising my knowledge of IT language.

Here we have the table of the main keyword that we can find on this language !

name | in cookie lang | description
:-: | :-: | :-:
function| **cookiedough** FunctionName(...){...}| Create a fonction
int variable| **cookint** intvariablename| Create a integer variable
string variable| **cookstring** stringvariablename| Create a string variable
char variable| **cookchar** charvariablename| Create a char variable
double variable| **cookdouble** doublevariablename| create a double variable
bool variable| **cookbool** boolvariablename| create a bool variable
return| **eat** variablename| Return a variable
display| **show** variablename| Display a variable
exit| **cookieGoAwayAndSay** statut| Exit with statut
for| **for** cookint;cond;cookint++/cookint--{...}| For loop
while| **while** cond{...}| While loop
condition| **if** cond {...}ifelse{...}else{...}| Condition

The structure of differents elements of a cookielang code :

![alt](https://raw.githubusercontent.com/erwanaubry/CookieLang/main/img/diagCode.drawio.png)

The block **operation** correspond to all arithmetic operation we can know with the symbole +, -, *, , /, <<, >>.

## Requirments

You will need of ruby on your computer to run this software :

    sudo apt install ruby-full

And install the required libraries :

    bundle install

The list of package that I had used :

- strscan
- logger
- colorize
- optparse
- test/unit

## Run the software

For compile the project, you can just run this command :

    rake

The Rakefil will run the unit tests and the installation.

You can now run this software with the command :

    ./bin/cookielang

And you will can see :

![alt](https://raw.githubusercontent.com/erwanaubry/CookieLang/main/img/help.png)

Like the help page you must specify a script developed in cookielang with the flag **--file**, like it :

    ./bin/cookielang --file test/script/functionTest.cookie --verbose

## Install this software

Build the application :

    gem build cookielang.gemspec

Install the software :

    gem install cookielang-1.0.0.gem

Run the software :

    ./bin/cookielang
## Bugs
