#!/bin/bash
ffplay -f lavfi -i $(python .py $@) -v panic -stats