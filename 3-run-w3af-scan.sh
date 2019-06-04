#!/bin/bash
OPTIONS="--rm --service-ports"
SHARED_DATA="../SharedData"
SCANS="conf/*.w3af"

# Copy scan config files to the share
cp $SCANS "$SHARED_DATA"

# Run w3af scan
# ./w3af_console [-s <script_file>]
#    -s <script_file> or --script=<script_file>   Run <script_file> script
#    -n or --no-update                            No update check will be made when starting. This option takes 
#    -f or --force-update                         An update check will be made when starting. This option takes 
#    -p <profile> or --profile=<profile>          Run with the selected <profile>
#    -P <profile> or --profile-run=<profile>      Run with the selected <profile> in batch mode
# For more info visit http://w3af.org/
#docker-compose run $OPTIONS --name w3af w3af ./w3af_console -s /share/dvna-auth1.w3af
#docker-compose run $OPTIONS --name w3af w3af /bin/bash
docker-compose run $OPTIONS --name w3af w3af sh -c "cp -rp /share/.w3af /home/w3af && ./w3af_console -s /share/dvna-auth1.w3af"
