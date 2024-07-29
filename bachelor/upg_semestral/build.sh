#!/bin/bash
mkdir -p bin
javac -cp ./lib/jfreechart-1.5.3.jar:./lib/org.jfree.svg-4.2.jar:./src/main/java -encoding UTF-8 -d bin/ ./src/main/java/graphics/* ./src/main/java/model/* ./src/main/java/logic/*
