## Test OWASP Zed Attack Proxy (ZAP)

- In Terminal 2: 
    - Run test scan via `./2-run-zap-baseline-scan.sh`:
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
    - Verify that an initial unauthenticated scan report was generated at [DVNA-BaselineScanReport.html](../SharedData/DVNA-BaselineScanReport.html), with medium(2)/low(6)/informational(2) findings

        ```bash
        # On Docker Host:
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