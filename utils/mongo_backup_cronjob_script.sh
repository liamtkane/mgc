#!/usr/bin/env bash

mkdir ~/software/cronjob/
cd ~/software/cronjob/ && nextflow ~/software/mgc/nextflow/mongo_backup.nf
cd ~/software/ && sudo rm -rf cronjob/