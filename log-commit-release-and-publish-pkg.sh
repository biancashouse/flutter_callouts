#!/bin/bash

./cider-log.sh

./cider-bump.sh

cider release

git commit -a -m "release `cider version`" && git tag "`cider version`" && dart pub publish
