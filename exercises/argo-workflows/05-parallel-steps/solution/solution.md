# Solution

The `withItems` and `withParam` functionality work somewhat similar. They both help with creating steps dynamically based on the number of items in a given collection (map or array).

The first workflow uses `withItems`. The items have been provided in the form of an array. Each item can be referenced using the `item` variable.

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: print-message-
spec:
  entrypoint: main
  templates:
  - name: main
    steps:
    - - name: echo
        arguments:
          parameters:
          - name: message
            value: "{{ item }}"
        template: echo
        withItems:
        - a
        - b
        - c
  - name: echo
    inputs:
      parameters:
      - name: message
    script:
      image: alpine:3.20.0
      command: ["/bin/sh"]
      source: echo "{{ inputs.parameters.message }}"
```

Submitting the workflow will create three steps, one for each given item in the array.

```
$ argo submit -n argo --watch echo-step-withitems.yaml
Name:                print-message-vs2lm
Namespace:           argo
ServiceAccount:      unset (will run with the default ServiceAccount)
Status:              Succeeded
Conditions:
 PodRunning          False
 Completed           True
Created:             Tue Jun 11 14:55:08 -0600 (10 seconds ago)
Started:             Tue Jun 11 14:55:08 -0600 (10 seconds ago)
Finished:            Tue Jun 11 14:55:18 -0600 (now)
Duration:            10 seconds
Progress:            3/3
ResourcesDuration:   0s*(1 cpu),6s*(100Mi memory)

STEP                    TEMPLATE  PODNAME                              DURATION  MESSAGE
 ✔ print-message-vs2lm  main
 └─┬─✔ echo(0:a)        echo      print-message-vs2lm-echo-3849763398  5s
   ├─✔ echo(1:b)        echo      print-message-vs2lm-echo-959200844   6s
   └─✔ echo(2:c)        echo      print-message-vs2lm-echo-3080110302  6s
```

The `withParam` notation requires you to provide a JSON array. The value for the JSON array has been made available as argument parameter and is then passed down to the template.

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: print-message-
spec:
  arguments:
    parameters:
    - name: messages
      value: '["a", "b", "c"]'
  entrypoint: main
  templates:
  - name: main
    inputs:
      parameters:
      - name: messages
    steps:
    - - name: echo
        arguments:
          parameters:
          - name: message
            value: "{{ item }}"
        template: echo
        withParam: "{{ inputs.parameters.messages }}"
  - name: echo
    inputs:
      parameters:
      - name: message
    script:
      image: alpine:3.20.0
      command: ["/bin/sh"]
      source: echo "{{ inputs.parameters.message }}"
```

Submitting the workflow without the argument parameter `messages` will use the default value.

```
$ argo submit -n argo --watch echo-step-withparam.yaml
Name:                print-message-ztmq8
Namespace:           argo
ServiceAccount:      unset (will run with the default ServiceAccount)
Status:              Succeeded
Conditions:
 PodRunning          False
 Completed           True
Created:             Tue Jun 11 14:53:19 -0600 (10 seconds ago)
Started:             Tue Jun 11 14:53:19 -0600 (10 seconds ago)
Finished:            Tue Jun 11 14:53:29 -0600 (now)
Duration:            10 seconds
Progress:            3/3
ResourcesDuration:   0s*(1 cpu),6s*(100Mi memory)
Parameters:
  messages:          ["a", "b", "c"]

STEP                    TEMPLATE  PODNAME                              DURATION  MESSAGE
 ✔ print-message-ztmq8  main
 └─┬─✔ echo(0:a)        echo      print-message-ztmq8-echo-1509459562  5s
   ├─✔ echo(1:b)        echo      print-message-ztmq8-echo-4055730768  5s
   └─✔ echo(2:c)        echo      print-message-ztmq8-echo-1623573618  5
```

You can override the default value for the argument parameter `messages` from the command line.

```
$ argo submit -n argo -p messages='["d","e","f"]' --watch echo-step-withparam.yaml
Name:                print-message-6kjp2
Namespace:           argo
ServiceAccount:      unset (will run with the default ServiceAccount)
Status:              Succeeded
Conditions:
 PodRunning          False
 Completed           True
Created:             Tue Jun 11 14:50:25 -0600 (10 seconds ago)
Started:             Tue Jun 11 14:50:25 -0600 (10 seconds ago)
Finished:            Tue Jun 11 14:50:35 -0600 (now)
Duration:            10 seconds
Progress:            3/3
ResourcesDuration:   0s*(1 cpu),6s*(100Mi memory)
Parameters:
  messages:          ["d","e","f"]

STEP                    TEMPLATE  PODNAME                              DURATION  MESSAGE
 ✔ print-message-6kjp2  main
 └─┬─✔ echo(0:d)        echo      print-message-6kjp2-echo-459669124   5s
   ├─✔ echo(1:e)        echo      print-message-6kjp2-echo-3573695792  5s
   └─✔ echo(2:f)        echo      print-message-6kjp2-echo-3668417780  5s