#!/bin/bash
mvn clean compile war:war -f pom.xml && scp -P 2222 ./target/lab2.war s243163@helios.cs.ifmo.ru:~/ && ssh -p 2222 s243163@helios.cs.ifmo.ru 'cd opt && . ./set-up-env.sh && ./deploy-glassfish-domain.sh ~/lab2.war'