#!/bin/bash

robot --output original.xml tests
returned=$?
echo I got $returned
if [ $returned -ne 0 ]; then
	echo  ========================
	echo  Failure ....
	echo  Rerun the failed ....
	echo  ========================
	robot --rerunfailed original.xml --output rerun.xml tests
	echo  ========================
	echo  Merge the results ....
	echo  ========================
	rebot --merge original.xml rerun.xml
else
	echo  PASSED form 1st trial
fi
