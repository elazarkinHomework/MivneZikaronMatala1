#!/bin/bash

#NUMBER OF ARGUMENTS
NOA=$#

if [ ${NOA} -lt "2" ];
then
	echo "USAGE $0 ‫‪<dir path> <program> <arguments if needed>"
	exit -1
fi

DIR_PATH=$1
PROGRAM=$2

cd ${DIR_PATH}

if [ ! -f Makefile ];
then
	echo "Makefile at ${DIR_PATH} not exist!"
	exit -2
fi

make all >/dev/null 2>&1

MAKE_OUT=$?

if [ ! -f ${PROGRAM} ];
then
	echo "program ${PROGRAM} not existed!"
	exit -3
fi

ARGS_LINE=""

for n in `seq 3 ${NOA}`;
do
	ARGS_LINE="${ARGS_LINE} ${!n}"
done

LOG_FILE=out.txt
#https://stackoverflow.com/questions/26711216/cheking-memory-with-valgrind-with-bash-script

valgrind --leak-check=full ./${PROGRAM} ${ARGS_LINE} >${LOG_FILE} 2>&1
grep -q "ERROR SUMMARY: 0 errors" ${LOG_FILE}
LEAK_TEST_OUT=$?

valgrind --tool=helgrind ./${PROGRAM} ${ARGS_LINE} >${LOG_FILE} 2>&1
grep -q "ERROR SUMMARY: 0 errors" ${LOG_FILE}
THREAD_TRACE_OUT=$?

rm ${LOG_FILE}

if [ $MAKE_OUT -eq "0" ];
then
	MAKE_PRINT="PASS"
else
	MAKE_PRINT="FAIL"
fi

if [ $LEAK_TEST_OUT -eq "0" ];
then
	LEAK_PRINT="PASS"
else
	LEAK_PRINT="FAIL"
fi

if [ $THREAD_TRACE_OUT -eq "0" ];
then
	THREAD_PRINT="PASS"
else
	THREAD_PRINT="FAIL"
fi

echo "	Compilation	Memory leaks	Thread race"
echo "	 ${MAKE_PRINT}	 	 ${LEAK_PRINT}	 	 ${THREAD_PRINT}"

EXIT_VAL=$(((MAKE_OUT<<2) + (LEAK_TEST_OUT<<1) + THREAD_TRACE_OUT))

exit $EXIT_VAL
