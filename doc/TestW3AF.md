# Testing W3AF

- In Terminal 2: 
    - Run the w3af_console within a bash shell in the w3af container via `./3-run-w3af-shell.sh`:

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