# pipeline-appscan
Consolidation of ideas/scripts for automating app scans by using opensource tools from a dev pipeline. I'll be starting with dynamic web app scanning and I may evolve this into other areas such as static analysis and web services testing later.

__CONTENT__

<!-- TOC -->

- [pipeline-appscan](#pipeline-appscan)
    - [Purpose](#purpose)
    - [Initial Setup](#initial-setup)
        - [Get Docker Images](#get-docker-images)
        - [Start & Configure Test Web App](#start--configure-test-web-app)
    - [Sanity Checks](#sanity-checks)
        - [Test ZAP](#test-zap)
        - [Test W3AF](#test-w3af)
        - [Test Arachni](#test-arachni)
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
- Pull this repo and pull Docker images by running the included utility script `pull-docker-images.sh`:
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


### Start & Configure Test Web App

Start, configure and verify DVNA, as the test web app.

- In Terminal 1:
    - Start test app via `./start-dvna.sh`
        ```bash
        $ ./2-start-dvna.sh 
        Creating network "0-setup_default" with the default driver
        Creating dvna ... done
        Attaching to dvna
        dvna       | 
        dvna       | > dvna@0.0.1 start /app
        dvna       | > node server.js
        dvna       | 
        dvna       | Mon, 03 Jun 2019 23:39:35 GMT sequelize deprecated String based operators are now deprecated. Please use Symbol based operators for better security, read more at http://docs.sequelizejs.com/manual/tutorial/querying.html#operators at node_modules/sequelize/lib/sequelize.js:242:13
        dvna       | Executing (default): SELECT 1+1 AS result
        dvna       | Executing (default): CREATE TABLE IF NOT EXISTS `Products` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `code` VARCHAR(255) NOT NULL UNIQUE, `name` VARCHAR(255) NOT NULL, `description` TEXT NOT NULL, `tags` VARCHAR(255), `createdAt` DATETIME NOT NULL, `updatedAt` DATETIME NOT NULL);
        dvna       | Connection has been established successfully.
        dvna       | Executing (default): PRAGMA INDEX_LIST(`Products`)
        dvna       | Executing (default): PRAGMA INDEX_INFO(`sqlite_autoindex_Products_1`)
        dvna       | Executing (default): CREATE TABLE IF NOT EXISTS `Users` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` VARCHAR(255) NOT NULL, `login` VARCHAR(255) NOT NULL UNIQUE, `email` VARCHAR(255) NOT NULL, `password` VARCHAR(255) NOT NULL, `role` VARCHAR(255), `createdAt` DATETIME NOT NULL, `updatedAt` DATETIME NOT NULL);
        dvna       | Executing (default): PRAGMA INDEX_LIST(`Users`)
        dvna       | Executing (default): PRAGMA INDEX_INFO(`sqlite_autoindex_Users_1`)
        dvna       | It worked!
        ```
    - On the Docker host, add an entry in its host file for the test app: `echo "127.0.0.1 dvna" >> /etc/hosts`
    - Browse from host to test app at http://dvna:9090 or http://localhost:8080
        -  NOTE: all Docker containers will access the test app using the host name _dvna_ to access it (as per the name used in docker-compose.yml files).
    - Create a test account by clicking _Register a new account_ and using Login __tester__ Password __tester123__
    - Test new account and credentials 

## Sanity Checks

### Test ZAP

- In Terminal 2: 
    - Run test scan via `./run-zap-baseline-scan.sh`
        ```bash
        $ docker-compose ps
        Name    Command    State           Ports         
        -------------------------------------------------
        dvna   npm start   Up      0.0.0.0:9090->9090/tcp

        $ ./2-run-zap-baseline-scan.sh 
        [...]
        WARN-NEW: CSP Scanner: Wildcard Directive [10055] x 3 
                http://dvna:9090/sitemap.xml
                http://dvna:9090/robots.txt
                http://dvna:9090/favicon.ico
        WARN-NEW: Absence of Anti-CSRF Tokens [10202] x 3 
                http://dvna:9090/login
                http://dvna:9090/register
                http://dvna:9090/forgotpw
        FAIL-NEW: 0     FAIL-INPROG: 0  WARN-NEW: 9     WARN-INPROG: 0  INFO: 0 IGNORE: 0       PASS: 47
        ```
    - Verify that an initial unauthenticated scan report was generated at [wrk/DVNA-BaselineScanReport.html](wrk/DVNA-BaselineScanReport.html), with medium(2)/low(6)/informational(2) findings
        ```bash
        $ ls ../SharedData/DVNA-Baseline*
        ../SharedData/DVNA-BaselineScanReport.html ../SharedData/DVNA-BaselineScanReport.json ../SharedData/DVNA-BaselineScanReport.md   ../SharedData/DVNA-BaselineScanReport.xml
        ```
<!--
    - Optionally, test an authenticated Scan -- __WARNING: THE BELOW DOES NOT WORK!!!__ 
        - Run ZAP GUI via `./run-zap-gui-server.sh`
            - Browse from your host to http://localhost:8080/zap/
            - After ZAP GUI has loaded, load the existing context file wrk/dvna.context (should be located at /zap/wrk/dvna.context in the container) via __File->Import Context...__
            - Review the context parameters and adjust as needed 
            - Save the context back to [wrk/dvna.context](wrk.dvna.context)
            - Refer to [this page](https://github.com/zaproxy/zap-core-help/wiki/HelpStartConceptsAuthentication#configuration-example) for more configuration details.
        - Run authenticated scan via `./run-zap-auth-baseline-scan.sh`. This script loads the dvna.context file prior to scanning
        - View report [wrk/DVNA-BaselineScanReport.html](wrk/DVNA-BaselineScanReport.html)
        - __TODO__: Investigate [this ZAP authentication hook](https://hub.docker.com/r/ictu/zap2docker-weekly) or why `-n context_file` option did not work for me.
-->

### Test W3AF

- In Terminal 2: 
    - Run the w3af_console within a bash shell in the w3af container via `./run-w3af-shell.sh`:

        ```bash
        $ ./3-run-w3af-scan.sh 

        w3af>>> plugins
        w3af/plugins>>> output console, csv_file, html_file
        w3af/plugins>>> output config html_file
        w3af/plugins/output/config:html_file>>> set output_file /share/dvna-w3af.html
        w3af/plugins/output/config:html_file>>> set verbose True
        w3af/plugins/output/config:html_file>>> save
        The configuration has been saved.
        w3af/plugins/output/config:html_file>>> view
        |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
        | Setting                  | Value                                                                                                                  | Modified          | Description                                                                                                                     |
        |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
        | output_file              | /share/dvna-w3af.html                                                                                                  |                   | File name where this plugin will write to                                                                                       |
        | verbose                  | True                                                                                                                   |                   | True if debug information will be appended to the report.                                                                       |
        | template                 | w3af/plugins/output/html_file/templates/complete.html                                                                  |                   | The path to the HTML template used to render the report.                                                                        |
        |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
        w3af/plugins/output/config:html_file>>> back
        The configuration has been saved.
        w3af/plugins>>> output config csv_file
        w3af/plugins/output/config:csv_file>>> set output_file /share/dvna-w3af.csv
        w3af/plugins/output/config:csv_file>>> set verbose True
        Unknown option: "verbose".
        w3af/plugins/output/config:csv_file>>> save
        The configuration has been saved.
        w3af/plugins/output/config:csv_file>>> view
        |-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
        | Setting                        | Value                                                   | Modified               | Description                                                                                                                                                                           |
        |-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
        | output_file                    | /share/dvna-w3af.csv                                    |                        | The name of the output file where the vulnerabilities are be saved                                                                                                                    |
        |-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
        w3af/plugins/output/config:csv_file>>> back
        The configuration has been saved.
        w3af/plugins>>> output config console
        w3af/plugins/output/config:console>>> set verbose True
        w3af/plugins/output/config:console>>> save
        The configuration has been saved.
        w3af/plugins/output/config:console>>> back
        The configuration has been saved.
        w3af/plugins>>> crawl web_spider
        w3af/plugins>>> crawl config web_spider
        w3af/plugins/crawl/config:web_spider>>> set only_forward True
        w3af/plugins/crawl/config:web_spider>>> view
        |----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
        | Setting               | Value     | Modified       | Description                                                                                                                                                                                                                                         |
        |----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
        | only_forward          | True      | Yes            | When crawling only follow links to paths inside the one given as target.                                                                                                                                                                            |
        | ignore_regex          |           |                | When crawling, DO NOT follow links that match this regular expression. Please note that ignore_regex has precedence over follow_regex.                                                                                                              |
        | follow_regex          | .*        |                | When crawling only follow which that match this regular expression. Please note that ignore_regex has precedence over follow_regex.                                                                                                                 |
        |----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
        w3af/plugins/crawl/config:web_spider>>> back
        The configuration has been saved.
        w3af/plugins>>> audit xss
        w3af/plugins>>> back
        w3af>>> crawl web_spider
        Unknown command 'crawl'
        w3af>>> auth config generic
        Unknown command 'auth'
        w3af>>> set username tester
        Unknown command 'set'
        w3af>>> set check_url http://dvna:9090/learn
        Unknown command 'set'
        w3af>>> set check_string Logout
        Unknown command 'set'
        w3af>>> set password_field  password
        Unknown command 'set'
        w3af>>> set username_field username
        Unknown command 'set'
        w3af>>> set auth_url http://dvna:9090/login
        Unknown command 'set'
        w3af>>> set password tester123
        Unknown command 'set'
        w3af>>> view
        Unknown command 'view'
        w3af>>> back
        w3af>>> back
        w3af>>> target
        w3af/config:target>>> set target http://dvna:9090
        w3af/config:target>>> view
        |----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
        | Setting                                 | Value                                   | Modified            | Description                                                                                                                                                                                    |
        |----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
        | target_framework                        | unknown                                 |                     | Target programming framework (unknown/php/asp/asp.net/java/jsp/cfm/ruby/perl)                                                                                                                  |
        | target                                  | http://dvna:9090                        | Yes                 | A comma separated list of URLs                                                                                                                                                                 |
        | target_os                               | unknown                                 |                     | Target operating system (unknown/unix/windows)                                                                                                                                                 |
        |----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
        w3af/config:target>>> back
        The configuration has been saved.
        w3af>>> start
        Called w3afCore.start()
        Enabling _dns_cache()
        DNS response from DNS server for domain: dvna
        GET http://dvna:9090/ returned HTTP code "302" (id=1,from_cache=0,grep=1)
        GET http://dvna:9090/ returned HTTP code "302" (id=2,from_cache=0,grep=1)
        GET http://dvna:9090/ returned HTTP code "302" (id=3,from_cache=0,grep=1)
        GET http://dvna:9090/ returned HTTP code "302" (id=4,from_cache=0,grep=1)
        GET http://dvna:9090/ returned HTTP code "302" (id=5,from_cache=0,grep=1)
        GET http://dvna:9090/ returned HTTP code "302" (id=6,from_cache=0,grep=1)
        GET http://dvna:9090/ returned HTTP code "302" (id=7,from_cache=0,grep=1)
        GET http://dvna:9090/ returned HTTP code "302" (id=8,from_cache=0,grep=1)
        GET http://dvna:9090/ returned HTTP code "302" (id=9,from_cache=0,grep=1)
        GET http://dvna:9090/ returned HTTP code "302" (id=10,from_cache=0,grep=1)
        GET http://dvna:9090/ returned HTTP code "302" (id=11,from_cache=0,grep=1)
        GET http://dvna:9090/ returned HTTP code "302" (id=12,from_cache=0,grep=1)
        GET http://dvna:9090/ returned HTTP code "302" (id=13,from_cache=0,grep=1)
        GET http://dvna:9090/ returned HTTP code "302" (id=14,from_cache=0,grep=1)
        GET http://dvna:9090/ returned HTTP code "302" (id=15,from_cache=0,grep=1)
        GET http://dvna:9090/ returned HTTP code "302" (id=16,from_cache=0,grep=1)
        GET http://dvna:9090/ returned HTTP code "302" (id=17,from_cache=0,grep=1)
        Called _setup_audit()
        GET http://dvna:9090/ returned HTTP code "302" (id=18,from_cache=1,grep=1)
        GET http://dvna:9090/AsVRDTSS.do returned HTTP code "404" (id=19,from_cache=0,grep=0)
        GET http://dvna:9090/gISGiQVg.cgi returned HTTP code "404" (id=21,from_cache=0,grep=0)
        GET http://dvna:9090/VRbepfy4.htm returned HTTP code "404" (id=20,from_cache=0,grep=0)
        GET http://dvna:9090/pGD8K3Se.py returned HTTP code "404" (id=22,from_cache=0,grep=0)
        GET http://dvna:9090/Alo2eiM5.asp returned HTTP code "404" (id=24,from_cache=0,grep=0)
        GET http://dvna:9090/DhVJ5x5y.gif returned HTTP code "404" (id=23,from_cache=0,grep=0)
        GET http://dvna:9090/EqY6zzux.foobar returned HTTP code "404" (id=25,from_cache=0,grep=0)
        GET http://dvna:9090/dh6lifgZ.pl returned HTTP code "404" (id=27,from_cache=0,grep=0)
        GET http://dvna:9090/6mw53ous.xhtml returned HTTP code "404" (id=26,from_cache=0,grep=0)
        GET http://dvna:9090/zri12OVg.aspx returned HTTP code "404" (id=28,from_cache=0,grep=0)
        GET http://dvna:9090/33DvHas4.htmls returned HTTP code "404" (id=30,from_cache=0,grep=0)
        GET http://dvna:9090/WpKJDdD8.jsp returned HTTP code "404" (id=29,from_cache=0,grep=0)
        GET http://dvna:9090/kFqMbMJS.php returned HTTP code "404" (id=31,from_cache=0,grep=0)
        GET http://dvna:9090/lg4yANUU.rb returned HTTP code "404" (id=32,from_cache=0,grep=0)
        The 404 body result database has a length of 50.
        "http://dvna:9090/" (id:18) is NOT a 404 [similarity_index < 0.75 with sample path in 404 DB].
        GET http://dvna:9090/ returned HTTP code "302" (id=33,from_cache=1,grep=1)
        GET http://dvna:9090/ returned HTTP code "302" (id=34,from_cache=0,grep=0)
        xss plugin is testing: "Method: GET | http://dvna:9090/"
        Starting plugin: audit.xss
        Created 0 mutants for "Method: GET | http://dvna:9090/" ()
        web_spider plugin is testing: "Method: GET | http://dvna:9090/"
        Called _discover_worker(web_spider,http://dvna:9090/)
        Starting plugin: crawl.web_spider
        web_spider is testing "http://dvna:9090/"
        [web_spider] Crawling "http://dvna:9090/"
        GET http://dvna:9090/ returned HTTP code "302" (id=35,from_cache=1,grep=1)
        GET http://dvna:9090/login returned HTTP code "200" (id=36,from_cache=0,grep=0)
        "http://dvna:9090/login" (id:36) is NOT a 404 [similarity_index < 0.75 with sample path in 404 DB].
        [web_spider] Sending link to w3af core: "http://dvna:9090/login"
        New fuzzable request identified: "Method: GET | http://dvna:9090/login"
        New URL found by web_spider plugin: "http://dvna:9090/login"
        GET http://dvna:9090/login returned HTTP code "200" (id=37,from_cache=0,grep=0)
        xss plugin is testing: "Method: GET | http://dvna:9090/login"
        Starting plugin: audit.xss
        Created 0 mutants for "Method: GET | http://dvna:9090/login" ()
        web_spider plugin is testing: "Method: GET | http://dvna:9090/login"
        Called _discover_worker(web_spider,http://dvna:9090/login)
        Starting plugin: crawl.web_spider
        web_spider is testing "http://dvna:9090/login"
        [web_spider] Crawling "http://dvna:9090/login"
        GET http://dvna:9090/login returned HTTP code "200" (id=38,from_cache=1,grep=1)
        GET http://dvna:9090/ returned HTTP code "302" (id=39,from_cache=0,grep=0)
        [web_spider] Sending link to w3af core: "http://dvna:9090/"
        GET http://dvna:9090/assets/jquery-3.2.1.min.js returned HTTP code "200" (id=40,from_cache=0,grep=0)
        GET http://dvna:9090/register returned HTTP code "200" (id=41,from_cache=0,grep=0)
        GET http://dvna:9090/forgotpw returned HTTP code "200" (id=42,from_cache=0,grep=0)
        GET http://dvna:9090/assets/fa/css/font-awesome.min.css returned HTTP code "200" (id=43,from_cache=0,grep=0)
        GET http://dvna:9090/assets/showdown.min.js returned HTTP code "200" (id=44,from_cache=0,grep=0)
        New fuzzable request identified: "Method: POST | http://dvna:9090/login | URL encoded form: (username, password, login_0)"
        New fuzzable request identified: "Method: GET | http://dvna:9090/"
        New URL found by web_spider plugin: "http://dvna:9090/"
        GET http://dvna:9090/assets/qjeuyr-3.2.1.mni.js returned HTTP code "404" (id=45,from_cache=0,grep=0)
        "http://dvna:9090/assets/jquery-3.2.1.min.js" (id:40) is NOT a 404 [similarity_index < 0.9].
        [web_spider] Sending link to w3af core: "http://dvna:9090/assets/jquery-3.2.1.min.js"
        "http://dvna:9090/forgotpw" (id:42) is NOT a 404 [similarity_index < 0.75 with sample path in 404 DB].
        [web_spider] Sending link to w3af core: "http://dvna:9090/forgotpw"
        web_spider plugin is testing: "Method: POST | http://dvna:9090/login | URL encoded form: (username, password, login_0)"
        Called _discover_worker(web_spider,http://dvna:9090/login)
        Starting plugin: crawl.web_spider
        web_spider is testing "http://dvna:9090/login"
        [web_spider] Crawling "http://dvna:9090/login"
        New fuzzable request identified: "Method: GET | http://dvna:9090/assets/jquery-3.2.1.min.js"
        New URL found by web_spider plugin: "http://dvna:9090/assets/jquery-3.2.1.min.js"
        New fuzzable request identified: "Method: GET | http://dvna:9090/forgotpw"
        New URL found by web_spider plugin: "http://dvna:9090/forgotpw"
        "http://dvna:9090/register" (id:41) is NOT a 404 [similarity_index < 0.75 with sample path in 404 DB].
        [web_spider] Sending link to w3af core: "http://dvna:9090/register"
        POST http://dvna:9090/login with data: "username=&login_0=Submit&password=" returned HTTP code "302" (id=46,from_cache=0,grep=0)
        xss plugin is testing: "Method: POST | http://dvna:9090/login | URL encoded form: (username, password, login_0)"
        Starting plugin: audit.xss
        Created 3 mutants for "Method: POST | http://dvna:9090/login | URL encoded form: (username, password, login_0)" (post data: 3)
        POST http://dvna:9090/login with data: "username=John8212&login_0=Submit&password=FrAmE30." returned HTTP code "302" (id=47,from_cache=0,grep=1)
        New fuzzable request identified: "Method: GET | http://dvna:9090/register"
        New URL found by web_spider plugin: "http://dvna:9090/register"
        GET http://dvna:9090/assets/fa/css/oftn-aewosem.mni.css returned HTTP code "404" (id=48,from_cache=0,grep=0)
        "http://dvna:9090/assets/fa/css/font-awesome.min.css" (id:43) is NOT a 404 [similarity_index < 0.9].
        [web_spider] Sending link to w3af core: "http://dvna:9090/assets/fa/css/font-awesome.min.css"
        New fuzzable request identified: "Method: GET | http://dvna:9090/assets/fa/css/font-awesome.min.css"
        New URL found by web_spider plugin: "http://dvna:9090/assets/fa/css/font-awesome.min.css"
        GET http://dvna:9090/learn returned HTTP code "200" (id=49,from_cache=0,grep=0)
        Updating socket timeout for dvna:9090 from 6 to 0.683522350934 seconds
        web_spider plugin is testing: "Method: GET | http://dvna:9090/"
        Called _discover_worker(web_spider,http://dvna:9090/)
        Starting plugin: crawl.web_spider
        web_spider is testing "http://dvna:9090/"
        [web_spider] Crawling "http://dvna:9090/"
        POST http://dvna:9090/login with data: "username=rq2gt</->rq2gt/*rq2gt"rq2gtrq2gt'rq2gtrq2gt`rq2gtrq2gt =&login_0=S..." returned HTTP code "302" (id=50,from_cache=0,grep=1)
        GET http://dvna:9090/ returned HTTP code "302" (id=51,from_cache=0,grep=1)
        GET http://dvna:9090/ returned HTTP code "302" (id=52,from_cache=0,grep=0)
        xss plugin is testing: "Method: GET | http://dvna:9090/"
        Starting plugin: audit.xss
        Created 0 mutants for "Method: GET | http://dvna:9090/" ()
        Created 6 mutants for "Method: POST | http://dvna:9090/login | URL encoded form: (username, password, login_0)" (post data: 6)
        GET http://dvna:9090/assets/hswoodnw.mni.js returned HTTP code "404" (id=53,from_cache=0,grep=0)
        "http://dvna:9090/assets/showdown.min.js" (id:44) is NOT a 404 [similarity_index < 0.9].
        [web_spider] Sending link to w3af core: "http://dvna:9090/assets/showdown.min.js"
        New fuzzable request identified: "Method: GET | http://dvna:9090/assets/showdown.min.js"
        New URL found by web_spider plugin: "http://dvna:9090/assets/showdown.min.js"
        "http://dvna:9090/learn" (id:49) is NOT a 404 [similarity_index < 0.75 with sample path in 404 DB].
        [web_spider] Sending link to w3af core: "http://dvna:9090/learn"
        New fuzzable request identified: "Method: GET | http://dvna:9090/learn"
        New URL found by web_spider plugin: "http://dvna:9090/learn"
        POST http://dvna:9090/login with data: "username=ipkhn</->&login_0=Submit&password=FrAmE30." returned HTTP code "302" (id=54,from_cache=0,grep=1)
        POST http://dvna:9090/login with data: "username=tja3k'tja3k&login_0=Submit&password=FrAmE30." returned HTTP code "302" (id=55,from_cache=0,grep=1)
        POST http://dvna:9090/login with data: "username=r2osw =&login_0=Submit&password=FrAmE30." returned HTTP code "302" (id=56,from_cache=0,grep=1)
        POST http://dvna:9090/login with data: "username=azary"azary&login_0=Submit&password=FrAmE30." returned HTTP code "302" (id=58,from_cache=0,grep=1)
        POST http://dvna:9090/login with data: "username=dqnaf`dqnaf&login_0=Submit&password=FrAmE30." returned HTTP code "302" (id=57,from_cache=0,grep=1)
        web_spider plugin is testing: "Method: GET | http://dvna:9090/assets/jquery-3.2.1.min.js"
        Called _discover_worker(web_spider,http://dvna:9090/assets/jquery-3.2.1.min.js)
        Starting plugin: crawl.web_spider
        web_spider is testing "http://dvna:9090/assets/jquery-3.2.1.min.js"
        [web_spider] Crawling "http://dvna:9090/assets/jquery-3.2.1.min.js"
        GET http://dvna:9090/assets/jquery-3.2.1.min.js returned HTTP code "200" (id=59,from_cache=0,grep=0)
        POST http://dvna:9090/login with data: "username=xu4yg/*&login_0=Submit&password=FrAmE30." returned HTTP code "302" (id=60,from_cache=0,grep=1)
        xss plugin is testing: "Method: GET | http://dvna:9090/assets/jquery-3.2.1.min.js"
        Starting plugin: audit.xss
        Created 0 mutants for "Method: GET | http://dvna:9090/assets/jquery-3.2.1.min.js" ()
        GET http://dvna:9090/assets/jquery-3.2.1.min.js returned HTTP code "200" (id=61,from_cache=1,grep=1)
        GET http://dvna:9090/assets/ returned HTTP code "404" (id=62,from_cache=0,grep=0)
        GET http://dvna:9090/forgotpw returned HTTP code "200" (id=63,from_cache=0,grep=0)
        xss plugin is testing: "Method: GET | http://dvna:9090/forgotpw"
        Starting plugin: audit.xss
        Created 0 mutants for "Method: GET | http://dvna:9090/forgotpw" ()
        POST http://dvna:9090/login with data: "username=John8212&login_0=Submit&password=rvzkz</->rvzkz/*rvzkz"rvzkzrvzkz'..." returned HTTP code "302" (id=64,from_cache=0,grep=1)
        web_spider plugin is testing: "Method: GET | http://dvna:9090/forgotpw"
        Called _discover_worker(web_spider,http://dvna:9090/forgotpw)
        Starting plugin: crawl.web_spider
        web_spider is testing "http://dvna:9090/forgotpw"
        [web_spider] Crawling "http://dvna:9090/forgotpw"
        GET http://dvna:9090/forgotpw returned HTTP code "200" (id=65,from_cache=1,grep=1)
        Created 6 mutants for "Method: POST | http://dvna:9090/login | URL encoded form: (username, password, login_0)" (post data: 6)
        New fuzzable request identified: "Method: POST | http://dvna:9090/forgotpw | URL encoded form: (login, resetPasswordStart_0)"
        POST http://dvna:9090/login with data: "username=John8212&login_0=Submit&password=cfjs2/*" returned HTTP code "302" (id=66,from_cache=0,grep=1)
        GET http://dvna:9090/logout returned HTTP code "302" (id=67,from_cache=0,grep=0)
        "http://dvna:9090/logout" (id:67) is NOT a 404 [similarity_index < 0.75 with sample path in 404 DB].
        [web_spider] Sending link to w3af core: "http://dvna:9090/logout"
        New fuzzable request identified: "Method: GET | http://dvna:9090/logout"
        New URL found by web_spider plugin: "http://dvna:9090/logout"
        web_spider plugin is testing: "Method: GET | http://dvna:9090/register"
        Called _discover_worker(web_spider,http://dvna:9090/register)
        Starting plugin: crawl.web_spider
        web_spider is testing "http://dvna:9090/register"
        [web_spider] Crawling "http://dvna:9090/register"
        web_spider plugin is testing: "Method: GET | http://dvna:9090/assets/fa/css/font-awesome.min.css"
        Called _discover_worker(web_spider,http://dvna:9090/assets/fa/css/font-awesome.min.css)
        Starting plugin: crawl.web_spider
        web_spider is testing "http://dvna:9090/assets/fa/css/font-awesome.min.css"
        [web_spider] Crawling "http://dvna:9090/assets/fa/css/font-awesome.min.css"
        POST http://dvna:9090/login with data: "username=John8212&login_0=Submit&password=jfpis`jfpis" returned HTTP code "302" (id=68,from_cache=0,grep=1)
        POST http://dvna:9090/login with data: "username=John8212&login_0=Submit&password=lc8nh"lc8nh" returned HTTP code "302" (id=69,from_cache=0,grep=1)
        POST http://dvna:9090/login with data: "username=John8212&login_0=Submit&password=rhyu4</->" returned HTTP code "302" (id=70,from_cache=0,grep=1)
        POST http://dvna:9090/login with data: "username=John8212&login_0=Submit&password=ppjjf =" returned HTTP code "302" (id=71,from_cache=0,grep=1)
        GET http://dvna:9090/register returned HTTP code "302" (id=73,from_cache=0,grep=0)
        POST http://dvna:9090/login with data: "username=John8212&login_0=Submit&password=7kusr'7kusr" returned HTTP code "302" (id=72,from_cache=0,grep=1)
        GET http://dvna:9090/assets/fa/css/font-awesome.min.css returned HTTP code "200" (id=75,from_cache=0,grep=1)
        GET http://dvna:9090/register returned HTTP code "302" (id=74,from_cache=0,grep=1)
        xss plugin is testing: "Method: GET | http://dvna:9090/register"
        Starting plugin: audit.xss
        Created 0 mutants for "Method: GET | http://dvna:9090/register" ()
        GET http://dvna:9090/assets/fa/css/font-awesome.min.css returned HTTP code "200" (id=76,from_cache=0,grep=0)
        xss plugin is testing: "Method: GET | http://dvna:9090/assets/fa/css/font-awesome.min.css"
        Starting plugin: audit.xss
        Created 0 mutants for "Method: GET | http://dvna:9090/assets/fa/css/font-awesome.min.css" ()
        GET http://dvna:9090/assets/fa/ returned HTTP code "404" (id=77,from_cache=0,grep=0)
        GET http://dvna:9090/assets/fa/css/ returned HTTP code "404" (id=78,from_cache=0,grep=0)
        web_spider plugin is testing: "Method: GET | http://dvna:9090/assets/showdown.min.js"
        Called _discover_worker(web_spider,http://dvna:9090/assets/showdown.min.js)
        Starting plugin: crawl.web_spider
        web_spider is testing "http://dvna:9090/assets/showdown.min.js"
        [web_spider] Crawling "http://dvna:9090/assets/showdown.min.js"
        GET http://dvna:9090/assets/showdown.min.js returned HTTP code "200" (id=79,from_cache=0,grep=1)
        GET http://dvna:9090/assets/showdown.min.js returned HTTP code "200" (id=80,from_cache=0,grep=0)
        xss plugin is testing: "Method: GET | http://dvna:9090/assets/showdown.min.js"
        Starting plugin: audit.xss
        Created 0 mutants for "Method: GET | http://dvna:9090/assets/showdown.min.js" ()
        POST http://dvna:9090/login with data: "username=John8212&login_0=2cvj9</->2cvj9/*2cvj9"2cvj92cvj9'2cvj92cvj9`2cvj9..." returned HTTP code "302" (id=81,from_cache=0,grep=1)
        Created 6 mutants for "Method: POST | http://dvna:9090/login | URL encoded form: (username, password, login_0)" (post data: 6)
        web_spider plugin is testing: "Method: GET | http://dvna:9090/learn"
        Called _discover_worker(web_spider,http://dvna:9090/learn)
        Starting plugin: crawl.web_spider
        web_spider is testing "http://dvna:9090/learn"
        [web_spider] Crawling "http://dvna:9090/learn"
        POST http://dvna:9090/login with data: "username=John8212&login_0=wfxpr</->&password=FrAmE30." returned HTTP code "302" (id=82,from_cache=0,grep=1)
        POST http://dvna:9090/login with data: "username=John8212&login_0=5atix =&password=FrAmE30." returned HTTP code "302" (id=83,from_cache=0,grep=1)
        POST http://dvna:9090/login with data: "username=John8212&login_0=pjbib/*&password=FrAmE30." returned HTTP code "302" (id=84,from_cache=0,grep=1)
        web_spider plugin is testing: "Method: POST | http://dvna:9090/forgotpw | URL encoded form: (login, resetPasswordStart_0)"
        Called _discover_worker(web_spider,http://dvna:9090/forgotpw)
        Starting plugin: crawl.web_spider
        web_spider is testing "http://dvna:9090/forgotpw"
        [web_spider] Crawling "http://dvna:9090/forgotpw"
        [smart_fill] Failed to find a value for parameter with name "login"
        POST http://dvna:9090/login with data: "username=John8212&login_0=qr2nf'qr2nf&password=FrAmE30." returned HTTP code "302" (id=85,from_cache=0,grep=1)
        GET http://dvna:9090/learn returned HTTP code "200" (id=86,from_cache=0,grep=0)
        xss plugin is testing: "Method: GET | http://dvna:9090/learn"
        Starting plugin: audit.xss
        [smart_fill] Failed to find a value for parameter with name "login"
        Created 0 mutants for "Method: GET | http://dvna:9090/learn" ()
        POST http://dvna:9090/forgotpw with data: "login=56&resetPasswordStart_0=Submit" returned HTTP code "302" (id=88,from_cache=0,grep=1)
        POST http://dvna:9090/forgotpw with data: "login=&resetPasswordStart_0=Submit" returned HTTP code "302" (id=89,from_cache=0,grep=0)
        GET http://dvna:9090/learn returned HTTP code "200" (id=87,from_cache=0,grep=1)
        xss plugin is testing: "Method: POST | http://dvna:9090/forgotpw | URL encoded form: (login, resetPasswordStart_0)"
        Starting plugin: audit.xss
        Created 2 mutants for "Method: POST | http://dvna:9090/forgotpw | URL encoded form: (login, resetPasswordStart_0)" (post data: 2)
        POST http://dvna:9090/login with data: "username=John8212&login_0=ortdu`ortdu&password=FrAmE30." returned HTTP code "302" (id=91,from_cache=0,grep=1)
        POST http://dvna:9090/login with data: "username=John8212&login_0=k2p1o"k2p1o&password=FrAmE30." returned HTTP code "302" (id=90,from_cache=0,grep=1)
        web_spider plugin is testing: "Method: GET | http://dvna:9090/logout"
        Called _discover_worker(web_spider,http://dvna:9090/logout)
        Starting plugin: crawl.web_spider
        web_spider is testing "http://dvna:9090/logout"
        [web_spider] Crawling "http://dvna:9090/logout"
        GET http://dvna:9090/logout returned HTTP code "302" (id=92,from_cache=0,grep=1)
        POST http://dvna:9090/forgotpw with data: "login=3hwc3</->3hwc3/*3hwc3"3hwc33hwc3'3hwc33hwc3`3hwc33hwc3 =&resetPasswor..." returned HTTP code "302" (id=93,from_cache=0,grep=1)
        GET http://dvna:9090/logout returned HTTP code "302" (id=94,from_cache=0,grep=0)
        xss plugin is testing: "Method: GET | http://dvna:9090/logout"
        Starting plugin: audit.xss
        Created 0 mutants for "Method: GET | http://dvna:9090/logout" ()
        Created 6 mutants for "Method: POST | http://dvna:9090/forgotpw | URL encoded form: (login, resetPasswordStart_0)" (post data: 6)
        POST http://dvna:9090/forgotpw with data: "login=sz5im =&resetPasswordStart_0=Submit" returned HTTP code "302" (id=96,from_cache=0,grep=1)
        POST http://dvna:9090/forgotpw with data: "login=c60n8"c60n8&resetPasswordStart_0=Submit" returned HTTP code "302" (id=95,from_cache=0,grep=1)
        POST http://dvna:9090/forgotpw with data: "login=tl7ev</->&resetPasswordStart_0=Submit" returned HTTP code "302" (id=97,from_cache=0,grep=1)
        Updating socket timeout for dvna:9090 from 0.683522350934 to 1.18020601273 seconds
        Updating socket timeout for dvna:9090 from 0.683522350934 to 1.18020601273 seconds
        Updating socket timeout for dvna:9090 from 0.683522350934 to 1.18020601273 seconds
        POST http://dvna:9090/forgotpw with data: "login=bckag'bckag&resetPasswordStart_0=Submit" returned HTTP code "302" (id=98,from_cache=0,grep=1)
        POST http://dvna:9090/forgotpw with data: "login=dr2mc`dr2mc&resetPasswordStart_0=Submit" returned HTTP code "302" (id=99,from_cache=0,grep=1)
        POST http://dvna:9090/forgotpw with data: "login=u6ohe/*&resetPasswordStart_0=Submit" returned HTTP code "302" (id=100,from_cache=0,grep=1)
        GET http://dvna:9090/learn/vulnerability/a6_sec_misconf returned HTTP code "302" (id=101,from_cache=0,grep=0)
        GET http://dvna:9090/learn/vulnerability/a10_logging returned HTTP code "302" (id=103,from_cache=0,grep=0)
        GET http://dvna:9090/learn/vulnerability/a7_xss returned HTTP code "302" (id=102,from_cache=0,grep=0)
        GET http://dvna:9090/learn/vulnerability/a3_sensitive_data returned HTTP code "302" (id=104,from_cache=0,grep=0)
        GET http://dvna:9090/learn/vulnerability/ax_redirect returned HTTP code "302" (id=105,from_cache=0,grep=0)
        GET http://dvna:9090/learn/vulnerability/a5_broken_access_control returned HTTP code "302" (id=106,from_cache=0,grep=0)
        GET http://dvna:9090/learn/vulnerability/a4_xxe returned HTTP code "302" (id=110,from_cache=0,grep=0)
        GET http://dvna:9090/learn/vulnerability/a1_injection returned HTTP code "302" (id=107,from_cache=0,grep=0)
        GET http://dvna:9090/learn/vulnerability/a8_ides returned HTTP code "302" (id=109,from_cache=0,grep=0)
        GET http://dvna:9090/learn/vulnerability/a2_broken_auth returned HTTP code "302" (id=108,from_cache=0,grep=0)
        GET http://dvna:9090/learn/vulnerability/ax_csrf returned HTTP code "302" (id=111,from_cache=0,grep=0)
        GET http://dvna:9090/learn/vulnerability/a9_vuln_component returned HTTP code "302" (id=112,from_cache=0,grep=0)
        GET http://dvna:9090/learn/vulnerability/a10_olggnig returned HTTP code "302" (id=113,from_cache=0,grep=0)
        "http://dvna:9090/learn/vulnerability/a10_logging" (id:103) is a 404 (similarity_index > 0.9). Adding new knowledge to the 404_responses database (length=50).
        POST http://dvna:9090/forgotpw with data: "login=56&resetPasswordStart_0=b7kxe</->b7kxe/*b7kxe"b7kxeb7kxe'b7kxeb7kxe`b..." returned HTTP code "302" (id=114,from_cache=0,grep=1)
        Created 6 mutants for "Method: POST | http://dvna:9090/forgotpw | URL encoded form: (login, resetPasswordStart_0)" (post data: 6)
        GET http://dvna:9090/learn/ returned HTTP code "302" (id=115,from_cache=0,grep=0)
        "http://dvna:9090/learn/vulnerability/a6_sec_misconf" (id:101) is a 404 [similarity_index > 0.9]
        GET http://dvna:9090/learn/vulnerability/ returned HTTP code "404" (id=116,from_cache=0,grep=0)
        POST http://dvna:9090/forgotpw with data: "login=56&resetPasswordStart_0=tpgtp</->" returned HTTP code "302" (id=117,from_cache=0,grep=1)
        POST http://dvna:9090/forgotpw with data: "login=56&resetPasswordStart_0=ckcrq'ckcrq" returned HTTP code "302" (id=118,from_cache=0,grep=1)
        POST http://dvna:9090/forgotpw with data: "login=56&resetPasswordStart_0=xwagm"xwagm" returned HTTP code "302" (id=119,from_cache=0,grep=1)
        POST http://dvna:9090/forgotpw with data: "login=56&resetPasswordStart_0=cq28m =" returned HTTP code "302" (id=120,from_cache=0,grep=1)
        POST http://dvna:9090/forgotpw with data: "login=56&resetPasswordStart_0=ubv7e`ubv7e" returned HTTP code "302" (id=121,from_cache=0,grep=1)
        POST http://dvna:9090/forgotpw with data: "login=56&resetPasswordStart_0=xx0zt/*" returned HTTP code "302" (id=122,from_cache=0,grep=1)
        "http://dvna:9090/learn/vulnerability/ax_redirect" (id:105) is a 404 [similarity_index > 0.9]
        "http://dvna:9090/learn/vulnerability/a5_broken_access_control" (id:106) is a 404 [similarity_index > 0.9]
        "http://dvna:9090/learn/vulnerability/a7_xss" (id:102) is a 404 [similarity_index > 0.9]
        "http://dvna:9090/learn/vulnerability/a4_xxe" (id:110) is a 404 [similarity_index > 0.9]
        "http://dvna:9090/learn/vulnerability/a3_sensitive_data" (id:104) is a 404 [similarity_index > 0.9]
        "http://dvna:9090/learn/vulnerability/ax_csrf" (id:111) is a 404 [similarity_index > 0.9]
        "http://dvna:9090/learn/vulnerability/a1_injection" (id:107) is a 404 [similarity_index > 0.9]
        "http://dvna:9090/learn/vulnerability/a8_ides" (id:109) is a 404 [similarity_index > 0.9]
        "http://dvna:9090/learn/vulnerability/a2_broken_auth" (id:108) is a 404 [similarity_index > 0.9]
        "http://dvna:9090/learn/vulnerability/a9_vuln_component" (id:112) is a 404 [similarity_index > 0.9]
        "http://dvna:9090/learn/" (id:115) is a 404 [similarity_index > 0.9]
        The following is a list of broken links that were found by the web_spider plugin:
        - http://dvna:9090/learn/vulnerability/a6_sec_misconf [ referenced from: http://dvna:9090/learn ]
        - http://dvna:9090/assets/fa/ [ referenced from: http://dvna:9090/assets/fa/css/font-awesome.min.css ]
        - http://dvna:9090/assets/fa/css/ [ referenced from: http://dvna:9090/assets/fa/css/font-awesome.min.css ]
        - http://dvna:9090/assets/ [ referenced from: http://dvna:9090/assets/jquery-3.2.1.min.js ]
        - http://dvna:9090/learn/vulnerability/ax_redirect [ referenced from: http://dvna:9090/learn ]
        - http://dvna:9090/learn/vulnerability/ax_csrf [ referenced from: http://dvna:9090/learn ]
        - http://dvna:9090/learn/vulnerability/a5_broken_access_control [ referenced from: http://dvna:9090/learn ]
        - http://dvna:9090/learn/vulnerability/a7_xss [ referenced from: http://dvna:9090/learn ]
        - http://dvna:9090/learn/vulnerability/a10_logging [ referenced from: http://dvna:9090/learn ]
        - http://dvna:9090/learn/vulnerability/a9_vuln_component [ referenced from: http://dvna:9090/learn ]
        - http://dvna:9090/learn/vulnerability/a2_broken_auth [ referenced from: http://dvna:9090/learn ]
        - http://dvna:9090/learn/vulnerability/a1_injection [ referenced from: http://dvna:9090/learn ]
        - http://dvna:9090/learn/vulnerability/a8_ides [ referenced from: http://dvna:9090/learn ]
        - http://dvna:9090/learn/vulnerability/a3_sensitive_data [ referenced from: http://dvna:9090/learn ]
        - http://dvna:9090/learn/vulnerability/a4_xxe [ referenced from: http://dvna:9090/learn ]
        Found 9 URLs and 12 different injections points.
        The URL list is:
        - http://dvna:9090/
        - http://dvna:9090/assets/fa/css/font-awesome.min.css
        - http://dvna:9090/assets/jquery-3.2.1.min.js
        - http://dvna:9090/assets/showdown.min.js
        - http://dvna:9090/forgotpw
        - http://dvna:9090/learn
        - http://dvna:9090/login
        - http://dvna:9090/logout
        - http://dvna:9090/register
        The list of fuzzable requests is:
        - Method: GET | http://dvna:9090/
        - Method: GET | http://dvna:9090/
        - Method: GET | http://dvna:9090/assets/fa/css/font-awesome.min.css
        - Method: GET | http://dvna:9090/assets/jquery-3.2.1.min.js
        - Method: GET | http://dvna:9090/assets/showdown.min.js
        - Method: GET | http://dvna:9090/forgotpw
        - Method: GET | http://dvna:9090/learn
        - Method: GET | http://dvna:9090/login
        - Method: GET | http://dvna:9090/logout
        - Method: GET | http://dvna:9090/register
        - Method: POST | http://dvna:9090/forgotpw | URL encoded form: (login, resetPasswordStart_0)
        - Method: POST | http://dvna:9090/login | URL encoded form: (username, password, login_0)
        GET http://dvna:9090/login returned HTTP code "200" (id=123,from_cache=0,grep=0)
        GET http://dvna:9090/ returned HTTP code "302" (id=124,from_cache=0,grep=0)
        GET http://dvna:9090/logout returned HTTP code "302" (id=125,from_cache=0,grep=0)
        GET http://dvna:9090/register returned HTTP code "200" (id=127,from_cache=0,grep=0)
        GET http://dvna:9090/ returned HTTP code "302" (id=126,from_cache=0,grep=0)
        GET http://dvna:9090/learn returned HTTP code "302" (id=128,from_cache=0,grep=0)
        GET http://dvna:9090/forgotpw returned HTTP code "200" (id=129,from_cache=0,grep=0)
        POST http://dvna:9090/login with data: "username=&login_0=Submit&password=" returned HTTP code "302" (id=130,from_cache=0,grep=0)
        POST http://dvna:9090/forgotpw with data: "login=&resetPasswordStart_0=Submit" returned HTTP code "302" (id=132,from_cache=0,grep=0)
        GET http://dvna:9090/assets/showdown.min.js returned HTTP code "200" (id=131,from_cache=0,grep=0)
        GET http://dvna:9090/assets/jquery-3.2.1.min.js returned HTTP code "200" (id=133,from_cache=0,grep=0)
        GET http://dvna:9090/assets/fa/css/font-awesome.min.css returned HTTP code "200" (id=134,from_cache=0,grep=0)
        Scan finished in 5 seconds.
        Stopping the core...
        w3af>>> exit
        w3af>>> The user stopped the core, finishing threads...
        0 seconds. were needed to stop the core.

        Liked it? Donate some money!
        ```

### Test Arachni

- In Terminal 2: 
    - Run the Arachni scan: 

        ```bash
        $ ./4-run-arachni-scan.sh
        Arachni - Web Application Security Scanner Framework v1.5.1
        Author: Tasos "Zapotek" Laskos <tasos.laskos@arachni-scanner.com>

                (With the support of the community and the Arachni Team.)

        Website:       http://arachni-scanner.com
        Documentation: http://arachni-scanner.com/wiki


        [1;30m [~][1;00m No checks were specified, loading all.
        [1;30m [~][1;00m No element audit options were specified, will audit links, forms, cookies, UI inputs, UI forms, JSONs and XMLs.

        [1;34m [*][1;00m Initializing...
        [1;34m [*][1;00m Preparing plugins...
        [1;34m [*][1;00m AutoLogin: Logging in, please wait.
        [1;31m [-] [utilities#exception_jail:428][1;00m Session: [Arachni::Session::Error::FormNotFound] Login form could not be found with: {:url=>"http://dvna:9090/login", :inputs=>{"uid"=>"tester", "passw"=>"tester123"}}
        [1;31m [-] [utilities#exception_jail:428][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/session.rb:356:in `login_from_configuration'
        [1;31m [-] [utilities#exception_jail:428][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/session.rb:245:in `block in login'
        [1;31m [-] [utilities#exception_jail:428][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/utilities.rb:425:in `call'
        [1;31m [-] [utilities#exception_jail:428][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/utilities.rb:425:in `exception_jail'
        [1;31m [-] [utilities#exception_jail:428][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/session.rb:244:in `login'
        [1;31m [-] [utilities#exception_jail:428][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/components/plugins/autologin.rb:37:in `prepare'
        [1;31m [-] [utilities#exception_jail:428][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/plugin/manager.rb:69:in `block (2 levels) in run'
        [1;31m [-] [utilities#exception_jail:428][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/utilities.rb:425:in `call'
        [1;31m [-] [utilities#exception_jail:428][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/utilities.rb:425:in `exception_jail'
        [1;31m [-] [utilities#exception_jail:428][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/plugin/manager.rb:68:in `block in run'
        [1;31m [-] [utilities#exception_jail:428][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/plugin/manager.rb:65:in `each'
        [1;31m [-] [utilities#exception_jail:428][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/plugin/manager.rb:65:in `run'
        [1;31m [-] [utilities#exception_jail:428][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/framework/parts/state.rb:348:in `prepare'
        [1;31m [-] [utilities#exception_jail:428][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/framework.rb:110:in `run'
        [1;31m [-] [utilities#exception_jail:428][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/ui/cli/framework.rb:80:in `block in run'
        [1;31m [-] [utilities#exception_jail:429][1;00m Session: 
        [1;31m [-] [utilities#exception_jail:430][1;00m Session: Parent:
        [1;31m [-] [utilities#exception_jail:431][1;00m Session: Arachni::Session
        [1;31m [-] [utilities#exception_jail:432][1;00m Session: 
        [1;31m [-] [utilities#exception_jail:433][1;00m Session: Block:
        [1;31m [-] [utilities#exception_jail:434][1;00m Session: #<Proc:0x000000042ea2d0@/usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/session.rb:244>
        [1;31m [-] [utilities#exception_jail:435][1;00m Session: 
        [1;31m [-] [utilities#exception_jail:436][1;00m Session: Caller:
        [1;31m [-] [utilities#exception_jail:437][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/utilities.rb:425:in `exception_jail'
        [1;31m [-] [utilities#exception_jail:437][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/session.rb:244:in `login'
        [1;31m [-] [utilities#exception_jail:437][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/components/plugins/autologin.rb:37:in `prepare'
        [1;31m [-] [utilities#exception_jail:437][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/plugin/manager.rb:69:in `block (2 levels) in run'
        [1;31m [-] [utilities#exception_jail:437][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/utilities.rb:425:in `call'
        [1;31m [-] [utilities#exception_jail:437][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/utilities.rb:425:in `exception_jail'
        [1;31m [-] [utilities#exception_jail:437][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/plugin/manager.rb:68:in `block in run'
        [1;31m [-] [utilities#exception_jail:437][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/plugin/manager.rb:65:in `each'
        [1;31m [-] [utilities#exception_jail:437][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/plugin/manager.rb:65:in `run'
        [1;31m [-] [utilities#exception_jail:437][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/framework/parts/state.rb:348:in `prepare'
        [1;31m [-] [utilities#exception_jail:437][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/lib/arachni/framework.rb:110:in `run'
        [1;31m [-] [utilities#exception_jail:437][1;00m Session: /usr/local/arachni/system/gems/gems/arachni-1.5.1/ui/cli/framework.rb:80:in `block in run'
        [1;31m [-] [utilities#exception_jail:438][1;00m Session: --------------------------------------------------------------------------------
        [1;31m [-] [components/plugins/autologin#handle_error:84][1;00m AutoLogin: Could not find a form suiting the provided parameters.
        [1;30m [~][1;00m AutoLogin: Aborting the scan.
        [1;34m [*][1;00m ... done.


        ================================================================================


        [1;32m [+][1;00m Web Application Security Report - Arachni Framework

        [1;30m [~][1;00m Report generated on: 2019-06-04 02:33:13 +0000
        [1;30m [~][1;00m Report false positives at: http://github.com/Arachni/arachni/issues

        [1;32m [+][1;00m System settings:
        [1;30m [~][1;00m ---------------
        [1;30m [~][1;00m Version:           1.5.1
        [1;30m [~][1;00m Seed:              0f32bcff2e7dc7af2597d733da342b0f
        [1;30m [~][1;00m Audit started on:  2019-06-04 02:33:11 +0000
        [1;30m [~][1;00m Audit finished on: 2019-06-04 02:33:13 +0000
        [1;30m [~][1;00m Runtime:           00:00:02

        [1;30m [~][1;00m URL:        http://dvna:9090/
        [1;30m [~][1;00m User agent: Arachni/v1.5.1

        [1;34m [*][1;00m Audited elements: 
        [1;30m [~][1;00m * Links
        [1;30m [~][1;00m * Forms
        [1;30m [~][1;00m * Cookies
        [1;30m [~][1;00m * XMLs
        [1;30m [~][1;00m * JSONs
        [1;30m [~][1;00m * UI inputs
        [1;30m [~][1;00m * UI forms

        [1;34m [*][1;00m Checks: webdav, htaccess_limit, backdoors, backup_directories, insecure_client_access_policy, origin_spoof_access_restriction_bypass, interesting_responses, common_directories, common_files, insecure_cross_domain_policy_access, allowed_methods, http_only_cookies, cvs_svn_users, private_ip, credit_card, password_autocomplete, cookie_set_for_parent_domain, unencrypted_password_forms, insecure_cors_policy, captcha, hsts, x_frame_options, emails, insecure_cookies, html_objects, form_upload, mixed_resource, ssn, backup_files, common_admin_interfaces, localstart_asp, insecure_cross_domain_policy_headers, xst, directory_listing, http_put, path_traversal, os_cmd_injection, xss_path, sql_injection, xss_tag, unvalidated_redirect_dom, sql_injection_timing, source_code_disclosure, xss_dom, xss, unvalidated_redirect, code_injection_timing, xxe, response_splitting, session_fixation, xss_script_context, xss_event, xpath_injection, file_inclusion, csrf, xss_dom_script_context, rfi, os_cmd_injection_timing, ldap_injection, code_injection, no_sql_injection, trainer, no_sql_injection_differential, sql_injection_differential, code_injection_php_input_wrapper

        [1;34m [*][1;00m Filters: 
        [1;30m [~][1;00m   Exclude:
        [1;30m [~][1;00m     (?i-mx:logout)

        [1;30m [~][1;00m ===========================

        [1;32m [+][1;00m 0 issues were detected.


        [1;32m [+][1;00m Plugin data:
        [1;30m [~][1;00m ---------------


        [1;34m [*][1;00m AutoLogin
        [1;30m [~][1;00m ~~~~~~~~~~~~~~
        [1;30m [~][1;00m Description: 
        It looks for the login form in the user provided URL, merges its input fields
        with the user supplied parameters and sets the cookies of the response and
        request as framework-wide cookies.

        **NOTICE**: If the login form is by default hidden and requires a sequence of DOM
        interactions in order to become visible, this plugin will not be able to submit it.


        [1;32m [+][1;00m Could not find a form suiting the provided parameters.

        [1;30m [~][1;00m Report saved at: /dvna 2019-06-04 02_33_13 +0000.afr [0.0MB]
        [1;30m [~][1;00m The scan has logged errors: /usr/local/arachni/bin/../system/logs/framework/error-1.log

        [1;30m [~][1;00m Audited 0 page snapshots.

        [1;30m [~][1;00m Duration: 00:00:02
        [1;30m [~][1;00m Processed 8/8 HTTP requests.
        [1;30m [~][1;00m -- 0.0 requests/second.
        [1;30m [~][1;00m Processed 0/0 browser jobs.
        [1;30m [~][1;00m -- 0.0 second/job.

        [1;30m [~][1;00m Burst response time sum     0.93 seconds
        [1;30m [~][1;00m Burst response count        8
        [1;30m [~][1;00m Burst average response time 0.116 seconds
        [1;30m [~][1;00m Burst average               0.0 requests/second
        [1;30m [~][1;00m Timed-out requests          0
        [1;30m [~][1;00m Original max concurrency    20
        [1;30m [~][1;00m Throttled max concurrency   20
        ```

## Scanning in the Dev Pipeline

### Scan with multiple scanners

__TODO__: Develop the following:
* Run __SCRIPT_NAME__
* Check that script ran successfully

### Generate a Consolidated Report

__TODO__: Develop the following:
* Open report __REPORT_FILE_NAME__
* Check that report has ...

### Automation Hooks

__TODO__: Develop the following:
* To automate dynamic app scanning within your pipeline, the above has shown that you can ...


## Reference Information
- [OWASP Zed Attack Proxy (ZAP) CLI](https://github.com/zaproxy/zaproxy/wiki/Introduction)
- [W3AF's CLI](http://w3af.org/)
- The test web app used is [Damn Vulnerable NodeJS App](https://github.com/appsecco/dvna)
- The ZAP scan used is the [ZAP Baseline Scan](https://github.com/zaproxy/zaproxy/wiki/ZAP-Baseline-Scan)
- Andres Riancho's [w3af code repo](https://github.com/andresriancho/w3af/)
    - His [Docker Guide](https://github.com/andresriancho/w3af/tree/master/extras/docker)
- [Arachni's CLI](https://www.arachni-scanner.com/screenshots/command-line-interface/), [Docker image](https://hub.docker.com/r/arachni/arachni/) and [authentication options](http://support.arachni-scanner.com/kb/general-use/logging-in-and-maintaining-a-valid-session)
    - NOTE: Arachni's source code hasn't been touched for a while (> 6months).



