# Setup

- Pull this repo and [pull Docker images](../0-pull-docker-images.sh) by running the included utility script `0-pull-docker-images.sh`:

    ```bash
    $ git clone git@github.com:jourzero/pipeline-appscan.git

    $ cd pipeline-appscan

    $ ./0-pull-docker-images.sh 
    Get the test web app Damn Vulnerable NodeJS App (DVNA) docker image? [n] y
    sqlite: Pulling from appsecco/dvna
    [...]

    Get the ZAP docker image? [n] y
    Using default tag: latest
    latest: Pulling from owasp/zap2docker-weekly
    [...]

    Get the 'enhanced ZAP' docker image? [n] y
    latest: Pulling from ictu/zap2docker-weekly
    [...]

    Get the w3af docker image? [n] y
    Using default tag: latest
    latest: Pulling from andresriancho/w3af
    [...]

    Get the Arachni Docker image? [n] y
    Using default tag: latest
    latest: Pulling from arachni/arachni
    Digest: sha256:e88aa756b4660d8ad0059f383f3c070fdae36174a2231a960e228029ee4560ed
    Status: Image is up to date for arachni/arachni:latest

    $ docker image ls
    REPOSITORY                     TAG                 IMAGE ID            CREATED             SIZE
    [...]
    appsecco/dvna                  sqlite              4d74d852a9aa        7 months ago        270MB
    owasp/zap2docker-weekly        latest              8345ebb5240a        2 weeks ago         2.81GB
    ictu/zap2docker-weekly         latest              e135d85b38eb        7 weeks ago         1.84GB
    andresriancho/w3af             latest              f7b0c70471c6        3 years ago         683MB
    arachni/arachni                latest              96923d8ee837        5 months ago        741MB
    ```