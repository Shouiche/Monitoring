#!/usr/bin/env bash

. check.sh
CHECK_ARGS $#
CHECK_LOG_FILES
CHECK_GOACCESS

goaccess -f $log_file --log-format=COMBINED --ignore-panel=NOT_FOUND --ignore-panel=REQUESTS_STATIC --ignore-panel=OS --ignore-panel=REFERRING_SITES --ignore-panel=KEYPHRASES --ignore-panel=GEO_LOCATION -a -o report.html

#xdg-open report.html
