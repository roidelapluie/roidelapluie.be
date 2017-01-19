+++
title = "Cloning jenkins pipelines"
lang = "en"
date = "2013-12-16T08:57:43"
+++

<div class="box error">The content of this page is deprecated. Please see my <a href="http://www.youtube.com/watch?v=xeqk8v7IVCE">talk</a> about building pipelines at scale for more up-to-date information, together with the build flow plugin and the job DSL plugin.</div>

This script allows you to clone an entire pipeline. It clones every job in the pipeline, changes the name of the triggered jobs

Usage
---

    ./clone-pipeline.sh START-JOB PATTERN-TO-FIND-JOBS-TO-CLONE SED-TO-BE-DONE-ON-JOB-NAME

if you have a pipeline like that:

  * customer1-fetcher
  * customer1-tests
  * customer1-package
  * customer1-deploy
  * send-metric

you can clone it like that

    ./clone-pipeline.sh customer1-fetcher customer1 s/customer1/customer2/

you will get

  * customer2-fetcher
  * customer2-tests
  * customer2-package
  * customer2-deploy
  * send-metric

remarks:

  * the job that do not match |grep customer1 will not be cloned.
  * the cloned jobs will be disabled
  * the script requires augeas

Script
---

```bash
#!/bin/bash
job=$1
validate_grep=$2
sed_command=$3

print_job(){
    file=/var/lib/jenkins/jobs/$1/config.xml
    cat << END | augtool
set /augeas/load/Xml/incl[3] $file
set /augeas/load/Xml/lens Xml.lns
load
print /files$file
END
}
get_next_jobs(){
    file=/var/lib/jenkins/jobs/$1/config.xml
    cat << END | augtool | awk -F '"' '{print $2}' | sed 's/,/ /g'
set /augeas/load/Xml/incl[3] $file
set /augeas/load/Xml/lens Xml.lns
load
print /files$file/project/publishers/hudson.plugins.parameterizedtrigger.BuildTrigger/configs/hudson.plugins.parameterizedtrigger.BuildTriggerConfig/projects/#text
print /files$file/project/builders/hudson.plugins.parameterizedtrigger.TriggerBuilder/configs/hudson.plugins.parameterizedtrigger.BlockableBuildTriggerConfig/projects/#text
END
}
test_job(){
    echo $1|grep -q $validate_grep
}
update_job(){
    echo -en "\e[33m"
    echo Reading $1
    echo -en "\e[0m"

    if test_job $1
    then
        new_job=$(echo $1|sed $sed_command)
        echo -en "\e[34m"
        echo $job "->" $new_job
        echo -en "\e[0m"
        mkdir -p /var/lib/jenkins/jobs/$new_job/
        cp /var/lib/jenkins/jobs/$1/config.xml /var/lib/jenkins/jobs/$new_job/
        for job in $(get_next_jobs $1)
        do
            if test_job $job
            then
                sed -i /projects/s/$job/$(echo $job|sed $sed_command)/ /var/lib/jenkins/jobs/$new_job/config.xml
            fi
        done
        sed -i '/<disabled>'/s/false/true/ /var/lib/jenkins/jobs/$new_job/config.xml
    fi

    for job in $(get_next_jobs $1)
        do
        if test_job $job
        then
            echo -en "\e[32m"
            echo OK: $job
            echo -en "\e[0m"
            update_job $job
        else
            echo -en "\e[31m"
            echo NOK: $job
            echo -en "\e[0m"
        fi
    done
}


if [ -z "$job" ]
then
    echo -e "\e[32m"what is the starting job?"\e[0m"
    read job
fi
if [ -z "$validate_grep" ]
then
    echo -e "\e[32m"what is the grep validation for jobs?"\e[0m"
    read validate_grep
fi
if [ -z "$sed_command" ]
then
    echo -e "\e[32m"what should I sed?"\e[0m"
    read sed_command
fi

echo "trying to find the jobs of the pipeline..."

if [ -r /var/lib/jenkins/jobs/$job/config.xml ]
then

    echo -e "\e[32mfound the first one\e[0m"
    update_job $job

else
    echo "nothing found"
    exit 1
fi
```

