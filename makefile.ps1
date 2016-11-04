if ($args.count -eq 1){
	$a = $args[0]
}else { 
	Write-Host "Supply one of the parameters: test, test-suite, test-node, test-browser, test-local-node, test-local-browser, test-local-reverse-node, test-local-reverse-browser, test-local-reverse-node, test-local-reverse-browser, test-normalization-node, test-normalization-browser, test-coverage, test-local or coverage. "
}

function TestSuiteNode ($testSuite)
{
    if($testSuite){
         $env:JSONLD_TEST_SUITE=$testSuite
    }elseif (! $env:JSONLD_TEST_SUITE){
      return
    }    
    #Write-Host "		$env:JSONLD_TEST_SUITE"
	#Write-Host "		TestSuiteNode"
	$env:NODE_ENV="test" 
	node ./node_modules/mocha/bin/_mocha -A -R spec tests/test.js 	
}


function TestSuiteBrowser ($testSuite )
{
    if($testSuite){
         $env:JSONLD_TEST_SUITE=$testSuite
    }elseif (! $env:JSONLD_TEST_SUITE){
        return
    }   
    #Write-Host "		$env:JSONLD_TEST_SUITE"
	#Write-Host "		TestSuiteBrowser"
	$env:NODE_ENV="test" 
	node ./node_modules/phantomjs/bin/phantomjs tests/test.js 	
}

function TestLocal
{
     	node ./node_modules/mocha/bin/_mocha
}

switch ($a) 
    { 
        all {        	
        }
        test {
            TestLocal
            TestSuiteNode("../json-ld.org/test-suite")
            TestSuiteBrowser("../json-ld.org/test-suite")
            TestSuiteNode("./tests/new-embed-api")
            TestSuiteBrowser("./tests/new-embed-api")
            TestSuiteNode("../normalization/tests")
            TestSuiteBrowser("../normalization/tests")
            TestSuiteNode("./tests/new-reverse-api")
            TestSuiteBrowser("./tests/new-reverse-api")
        }
        test-suite {
            TestSuiteNode("")
            TestSuiteBrowser("")
        }
        test-node {
        	
        	TestSuiteNode("../json-ld.org/test-suite")
        } 
        test-browser {
        	
        	TestSuiteBrowser("../json-ld.org/test-suite")	
        } 
        test-local-node {
        	
        	TestSuiteNode("./tests/new-embed-api")
        } 
        test-local-browser {
        	
        	TestSuiteBrowser("./tests/new-embed-api")
        }
        test-local-reverse-node {        

        	TestSuiteNode("./tests/new-reverse-api")
        } 
        test-local-reverse-browser {
        	
            TestSuiteBrowser("./tests/new-reverse-api")
        } 
        test-normalization-node {
        
        	TestSuiteNode("../normalization/tests")	
        } 
        test-normalization-browser{
        	
            TestSuiteBrowser("../normalization/tests")
        }
        test-coverage {        	
        	node ./node_modules/istanbul/lib/cli cover ./node_modules/mocha/bin/_mocha -- -u exports -R spec tests/test.js
        } 
        test-local {
            TestLocal   
        }
        clean {
        	del coverage
        } 
        default {"No arguments are passed."}
    }