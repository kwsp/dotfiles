#!/bin/bash
docker build . -t kwsp/dotfiles && docker tag kwsp/dotfiles kwsp/dotfiles:latest && docker push kwsp/dotfiles:latest
