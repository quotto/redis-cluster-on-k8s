#!/bin/bash


cluster_option=""
for i in {0..5}; do
    while :; do
        target="${K8S_POD}.${K8S_SVC}"
        echo "nslookup ${target}"
        result=$(nslookup ${target})
        echo $result
       if [[ $result =~ Address:[[:space:]].+Address:[[:space:]]([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+) ]]; then
            ip=${BASH_REMATCH[1]}
            if [[ -n ${ip} ]]; then
                echo "get ip: ${target}->${ip}"
                cluster_option="${cluster_option} ${ip}:6379"
                break
            fi
        fi
        echo "waiting... ${target}"
        sleep 5
    done
done
echo "yes" | redis-cli --cluster create ${cluster_option} --cluster-replicas 1