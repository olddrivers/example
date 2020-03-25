#!/usr/bin/env bash

set -e

function terraform_plan(){
    echo "${action}"
    echo "${project}"
    pwd
}

function terraform_apply(){
    echo "${action}"
    echo "${project}"
    pwd
}

function main(){
    while getopts "a:p:" option;do
        case "${option}" in
            a)
            action=${OPTARG}
            ;;
            p)
            project=${OPTARG}
            ;;
            :)
            echo "Option -$OPTARG requires an argument" >&2
            exit 2
            ;;
            *) 
            echo "Unimplemented option: -$OPTARG" >&2; 
            exit 1
            ;;
        esac
    done

    if [ -z "${action}" -o -z "${project}" ]; then
        echo "missing parameters"
        exit 2
    fi

    case "${action}" in
        "plan")
        terraform_plan
        ;;
        "apply")
        terraform_apply
        ;;
        *) 
        echo "Unimplemented option: -$OPTARG" >&2; 
        exit 1
        ;;
        
    esac
}

main $@
