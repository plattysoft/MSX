#!/bin/bash

echo "export PROJECT_HOME=$(pwd)">.project
echo "export PATH=\$PATH:\$PROJECT_HOME/tools">>.project
mkdir src
mkdir res
mkdir tools

