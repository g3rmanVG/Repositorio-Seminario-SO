#!/bin/bash

echo "Hola Mundo" > mytext

cat mytext

mkdir -p backup

mv mytext backup/

ls backup

rm backup/mytext

rmdir backup


