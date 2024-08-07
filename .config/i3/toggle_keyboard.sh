#!/bin/bash

(setxkbmap -query | grep -q "layout:\s\+au") && setxkbmap cn || setxkbmap au
