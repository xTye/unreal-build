#!/bin/bash
# Sync the project from Perforce
p4 sync //depot/YourProject/...

# Build the Unreal project (specify your build settings)
ue4 build

# Deploy to GCP bucket
gsutil cp -r ./Binaries/ gs://your-bucket-name/
