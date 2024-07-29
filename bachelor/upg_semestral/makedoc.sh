#!/bin/bash
javadoc -encoding UTF-8 -sourcepath ./src/main/java -cp ./lib/jfreechart-1.5.3.jar:./lib/org.jfree.svg-4.2.jar:./src/main/java -d doc/javadoc -version -author ./src/main/java/graphics/*.java  ./src/main/java/model/*.java ./src/main/java/logic/*.java
