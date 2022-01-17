#!/bin/bash

source '.env'

terragrunt destroy-all --terragrunt-non-interactive
