#!/bin/bash
OPTIONS="--rm --service-ports"

#docker-compose run $OPTIONS --name arachni arachni /bin/bash
docker-compose run $OPTIONS --name arachni arachni /usr/local/arachni/bin/arachni http://dvna:9090 --plugin=autologin:url=http://dvna:9090/login,parameters="uid=tester&passw=tester123",check="Logout" --scope-exclude-pattern=logout
