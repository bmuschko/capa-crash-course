# Exercise 10

A customer provided you with a data dump in the form of JSON. You need to write a workflow that parses information from each entry in the provided JSON array. To speed up the processing procedure, execute the operation in 2 Pods in parallel.

1. Create a new workflow in file `data-processing.yaml`. Use the contents in [data.json](./data.json) to the define the value of a workflow parameter.
2. Add a template that executes a `jq` command for each entry in the JSON array with the container image [bmuschko/bash-jq:1.0.0](https://hub.docker.com/repository/docker/bmuschko/bash-jq). The command should parse the value of `size` attribute and print it to standard output.
3. Configure the execution of the JSON processing so that only 2 processing steps can run in parallel.
4. Execute the workflow and ensure the proper runtime behavior.