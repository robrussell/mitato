# Terminology

Using the terminology as it's [explained here](https://www.hanselman.com/blog/whats-the-difference-between-a-console-a-terminal-and-a-shell).

# Stop using cmd.exe

Apparently cmd is a shell but running cmd.exe in Windows brings up a very old console with this shell supporting it. Running WSL2 or Docker from inside of it will allow a connection to a Linux OS running Bash but the console is still cmd.

Since cmd doesn't support copy and paste or any normal ways to edit it's a very unproductive environment which is poorly integrated with modern software.

What we're looking for is a modern console backed by the bash shell.

# Git Bash

Github.com has a packaged up version of mingw which gives a slightly more unix feel to Windows since it's running bash shell. But in this case it's still the cmd console with many Linux utilities available.

# Good options
Both VSCode and Windows Terminal are modern and actively developed. Both support several shells including Power Shell, cmd, and bash. To use bash with them it's necessary to set up WSL2. In VSCode it's also straightforward to use Bash inside of a Docker container, though that can also be done in Windows Terminal with the Docker command line tool.

## VSCode

VSCode has a nice flexible console integrated in the bottom panel. It supports normal copy & paste with ctrl-c/ctrl-v. It's a little confusing how to use ctrl-c as a break command or ctrl-v to insert a character literal.

This console is handy when connecting to a Docker container or running commands related to a project you're working on.

## Windows Terminal

The latest release of Windows Terminal can be installed [from Github](https://github.com/microsoft/terminal/releases). It can be configured to use WSL2 by default, which gives you Bash. Do that.