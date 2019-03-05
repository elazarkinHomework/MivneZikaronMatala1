#!/bin/bash

echo "TEST1(with leak):"
./BasicCheck.sh test1 test1 100

echo "TEST2(without leak):"
./BasicCheck.sh test2 test2 100
