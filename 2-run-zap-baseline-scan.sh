#!/bin/bash
OPTIONS="--rm --service-ports"
TARGET="http://dvna:9090"
BASENAME="DVNA-BaselineScanReport"
ZAP_CONFIG="zap.conf"
ZAP_OPTIONS="-d"
ZAP_OPTIONS="-a -j -m 30"
SHARED_DATA="../SharedData"

# Copy zap.conf file to the zap share
cp "conf/$ZAP_CONFIG" "$SHARED_DATA"

# Run zap-baseline.py script. Ref.: https://github.com/zaproxy/zaproxy/wiki/ZAP-Baseline-Scan
# Usage: zap-baseline.py -t <target> [options]
#    -c config_file    config file to use to INFO, IGNORE or FAIL warnings
#    -r report_html    file to write the full ZAP HTML report
#    -w report_md      file to write the full ZAP Wiki (Markdown) report
#    -x report_xml     file to write the full ZAP XML report
#    -l level          minimum level to show: PASS, IGNORE, INFO, WARN or FAIL, use with -s to hide example URLs
#    -a                include the alpha passive scan rules as well
#    -j                use the Ajax spider in addition to the traditional one
#    -m mins           the number of minutes to spider for (default 1)
#    -d                show debug messages
docker-compose run $OPTIONS --name zap zap zap-baseline.py -t "$TARGET" -c "$ZAP_CONFIG" -r "${BASENAME}.html" -w "${BASENAME}.md" -x "${BASENAME}.xml" -J "${BASENAME}.json" $ZAP_OPTIONS
