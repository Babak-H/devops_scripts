#!/bin/bash

for i in $(seq 1 3000)
do
    curl https://WEBADDRESSTOHIT.com > test.txt
done