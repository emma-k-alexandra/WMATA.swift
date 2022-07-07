#!/bin/zsh

swift package \
    --allow-writing-to-directory ./docs \
    generate-documentation \
    --target WMATA \
    --disable-indexing \
    --transform-for-static-hosting \
    --hosting-base-path WMATA.swift \
    --output-path ./docs
