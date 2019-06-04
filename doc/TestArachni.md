# Test Arachni Scan

- In Terminal 2: 
    - Run test Arachni scan via `./4-run-arachni-scan.sh`:

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