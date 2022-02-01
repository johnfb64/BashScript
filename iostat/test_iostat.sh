#!/bin/bash
io = iostat -xd | awk '{print $1}'
echo $io
#if [  ]