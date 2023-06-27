#!/bin/bash
cd $HOME
gcc -m32 -g -z execstack -fno-stack-protector $HOME/vuln_prog.c -o $HOME/chall4
rm $HOME/vuln_prog.c