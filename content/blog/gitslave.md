+++
title = "Gitslave for Jenkins Pipelines"
lang = "en"
categories = ["Linux"]
tags = ["jenkins", "planet-inuits"]
slug = "gitslave-jenkins"
date = "2016-11-18T10:38:11"
+++

At customer, we are using [GitSlave](http://gitslave.sourceforge.net/), as a way
to build and release multiple releases at the same time. Gitslave is like git
submodules, except that you always get the latest version of the submodules (no
commits needed in the super repository).

For CI, we are using [Jenkins](https://jenkins.io). A Jenkins plugin was developed for it.
Unfortunately, it was written in a way that would make the work of opensourcing
that module too big (IP was all over the place in the testsuite). In addition to
that, the integration with Jenkins was not as best as with the Git plugin.

The multi scm plugin is not an option as the list of repos to clone is in a
file; and that it sometimes changes.

Fortunately, we will eventually drop that proprietary module, switching to the
new [Pipeline plugin](https://wiki.jenkins-ci.org/display/JENKINS/Pipeline+Plugin).
I would then like to share a Jenkinsfile script that takes the `.gitslave`
configuration file and clones every repository. Please note that it takes some
parameters: `gitBaseUrl`, and `superRepo`. It will clone the repositories in
multiple threads.

```
lock('checkout') {
    def checkouts = [:]
    def threads = 8

    stage('Super Repo') {
        checkout([$class: 'GitSCM',
                branches: [[name: branch]],
                doGenerateSubmoduleConfigurations: false,
                extensions: [[$class: 'CleanCheckout'], [$class: 'ScmName', name: 'super']],
                submoduleCfg: [],
                userRemoteConfigs: [[url: "${gitBaseUrl}/${superRepo}"]]])

        def repos = readFile('.gitslave')
        def reposLines = repos.readLines()
        for (i = 0; i < threads; i++){
            checkouts["Thread ${i}"] = []
        }
        def idx = 0
        for (line in reposLines) {
            def repoInfo = line.split(' ')
            def repoUrl = repoInfo[0]
            def repoPath = repoInfo[1]
            def curatedRepoUrl = repoUrl.substring(4, repoUrl.length()-1)
            def curatedRepoPath = repoPath.substring(1, repoPath.length()-1)
            echo("Thread ${idx%threads}")
            checkouts["Thread ${idx%threads}"] << [path: curatedRepoPath, url: "${gitBaseUrl}/${curatedRepoUrl}"]
            idx++
        }
    }
    stage('GitSlave Repos') {
        def doCheckouts = [:]
        for (i = 0; i < threads; i++){
            def j = i
            doCheckouts["Thread ${j}"] = {
                for (co in checkouts["Thread ${j}"]) {
                    retry(3) {
                        checkout([$class: 'GitSCM',
                                branches: [[name: branch]],
                                doGenerateSubmoduleConfigurations: false,
                                extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: co.path], [$class: 'CleanCheckout'], [$class: 'ScmName', name: co.path]],
                                submoduleCfg: [],
                                userRemoteConfigs: [[url: co.url]]])
                    }
                }
            }
        }
        parallel doCheckouts
    }
}
```

That script is under [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

Why do we run in threads and not everything in parallel? First, [Blue Ocean](https://jenkins.io/projects/blueocean/)
[can only display 100 threads](https://issues.jenkins-ci.org/browse/JENKINS-39770). Running several operations in all the repos
would end up with more that 100 threads. Plus it is probably not clever to
run such a big amount of parallelism.

What is still to be done? We do not delete repositories that disappear from the
`.gitslave` file.

Here is the result:

![GitSlave in Jenkins Pipeline](|filename|/images/jenkins-bo-gitslave.png)

PS: GitSlave is named GitSlave. I do not like the name -- and kudos to the
Jenkins team to drop the Master/Slave terminology as part of the Jenkins 2.0
release.
