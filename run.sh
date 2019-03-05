#!/bin/bash

echo "TEST1(with leak):"
echo "will run command: ./BasicCheck.sh test1 test1 100"
./BasicCheck.sh test1 test1 100

echo "TEST2(without leak):"
echo "will run command: ./BasicCheck.sh test2 test2 100"
./BasicCheck.sh test2 test2 100
