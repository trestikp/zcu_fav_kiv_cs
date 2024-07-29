#!/bin/bash

# script must have exactly 1 parameter, which is test case name
if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
    echo $#
    exit 1
fi

# option A to create directories instead of long file names for .txt files
# option a creates logs to text files with long names
# option r prints a small summary report - irrelevant for elastic
cd soap_res/ && ../SoapUI-5.7.0/bin/testrunner.sh -JMrI -c "$1" ../soapui_project/REST-PTE-soapui-project.xml && cd ..
