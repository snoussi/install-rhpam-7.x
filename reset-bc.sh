#!/bin/bash

echo "Resetting RHPAM"
rm -rf ./pam-data
rm -rf ./standalone/data
rm -rf ./standalone/tmp
rm -rf ./standalone/log/*