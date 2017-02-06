#!/bin/bash
#
# author Everton de Vargas Agilar <<evertonagilar@gmail.com>>
#

current_dir=$(dirname $0)
cd $current_dir
deps=$(ls -d deps/*/ebin 2> /dev/null)

/usr/bin/erl -pa $current_dir/ebin $deps \
	-eval "application:start(ecsv2sqlite)"
