# pipeline-appscan
Consolidation of ideas/scripts for automating app scans by using opensource tools from a dev pipeline. I'll be starting with dynamic web app scanning and I may evolve this into other areas such as static analysis and web services testing later.

__CONTENT__

<!-- TOC -->

- [pipeline-appscan](#pipeline-appscan)
    - [Purpose](#purpose)
    - [Initial Setup](#initial-setup)
        - [Get Docker Images](#get-docker-images)
        - [Start & Configure Test Web App](#start--configure-test-web-app)
        - [Sanity Checks for App Scanners](#sanity-checks-for-app-scanners)
    - [Scanning in the Dev Pipeline](#scanning-in-the-dev-pipeline)
        - [Scan with multiple scanners](#scan-with-multiple-scanners)
        - [Generate a Consolidated Report](#generate-a-consolidated-report)
        - [Automation Hooks](#automation-hooks)
    - [Reference Information](#reference-information)

<!-- /TOC -->


## Purpose

Here's this project's main (initial) purpose.

* Perform automated dynamic web app scanning using free/opensource tools:
	- [OWASP Zed Attack Proxy (ZAP)](https://github.com/zaproxy/zaproxy/wiki/Introduction)
	- [W3AF](http://w3af.org/)
	- [Arachni](https://www.arachni-scanner.com)
* Criteria for each dynamic app scanning tool:
    - Have a CLI and a pass/fail output that lends itself well for automation
    - Have a free version available for commercial usage (even if less limited than a paid version)
    - Support authenticated scans
    - Allow automatic native reporting generation. Single-page HTML format is preferred.
    - Allow automatic data exports for normalized/consolidated reporting or trending. XML format is preferred.


## Initial Setup

### Get Docker Images

- Work on a [Docker host](https://docs.docker.com/)
- Pull this repo and [pull Docker images](0-pull-docker-images.sh) by running the included utility script `0-pull-docker-images.sh` [(_example here..._)](doc/Setup.md)


### Start & Configure Test Web App

Start, configure and verify DVNA, as the test web app.

- In Terminal 1:
    - Start [DVNA test app](1-start-dvna.sh) via `./1-start-dvna.sh`  -- [(_example here..._)](doc/StartDVNA.md)
    - On the Docker host, add an entry in its host file for the test app: `echo "127.0.0.1 dvna" >> /etc/hosts`
    - Browse from host to test app at http://dvna:9090 or http://localhost:8080
        -  NOTE: all Docker containers will access the test app using the host name _dvna_ to access it (as per the name used in docker-compose.yml files).
    - Create a test account by clicking _Register a new account_ and using Login __tester__ Password __tester123__
    - Test new account and credentials 

### Sanity Checks for App Scanners

- Run a [test ZAP scan](2-run-zap-baseline-scan.sh) via `./2-run-zap-baseline-scan.sh` [(_example here..._)](doc/TestZAP.md)
- Run a [test W3AF scan](3-run-w3af-scan.sh) via `./3-run-w3af-scan.sh` [(_example here..._)](doc/TestW3AF.md)
- Run a [test Arachni scan](4-run-arachni-scan.sh) via `./4-run-arachni-scan.sh` [(_example here..._)](doc/TestArachni.md)

## Scanning in the Dev Pipeline

### Scan with multiple scanners

__TODO__: Develop the following.

After every integration / release, dep:
* Run __{SCRIPT_NAME} {URL}__
* Check that script ran successfully

### Generate a Consolidated Report

__TODO__: Develop the following:
* Open report __{REPORT_FILE_NAME}__
* Check that report has ...

### Automation Hooks

__TODO__: Develop the following:
* To automate dynamic app scanning within your pipeline, you can ...


## Reference Information
- [OWASP Zed Attack Proxy (ZAP) CLI](https://github.com/zaproxy/zaproxy/wiki/Introduction)
- [W3AF's CLI](http://w3af.org/)
- The test web app used is [Damn Vulnerable NodeJS App](https://github.com/appsecco/dvna)
- The ZAP scan used is the [ZAP Baseline Scan](https://github.com/zaproxy/zaproxy/wiki/ZAP-Baseline-Scan)
- Andres Riancho's [w3af code repo](https://github.com/andresriancho/w3af/)
    - His [Docker Guide](https://github.com/andresriancho/w3af/tree/master/extras/docker)
- [Arachni's CLI](https://www.arachni-scanner.com/screenshots/command-line-interface/), [Docker image](https://hub.docker.com/r/arachni/arachni/) and [authentication options](http://support.arachni-scanner.com/kb/general-use/logging-in-and-maintaining-a-valid-session)
    - NOTE: Arachni's source code hasn't been touched for a while (> 6months).



