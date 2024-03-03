#!/bin/bash

MODELS="mistral gemma:2b gemma:7b llama2:latest orca-mini phi"
for m in $MODELS
do
  echo "Checking $m"
  ollama pull $m
done
