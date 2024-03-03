# Solution

Create the Secret with the following commands. Ensure to create the Secret in the namespace that runs the workflow. By default, that is the `argo` namespace.

```
$ export DOCKER_USERNAME=******
$ export DOCKER_TOKEN=******
$ kubectl create secret generic docker-config -n argo --from-literal="config.json={\"auths\": {\"https://index.docker.io/v1/\": {\"auth\": \"$(echo -n $DOCKER_USERNAME:$DOCKER_TOKEN|base64)\"}}}"
secret/docker-config created
```

The existing workflow file already sets up most of the template logic. Define the Volume that references the Secret and mount it to the container. Inject the environment variable `DOCKER_CONFIG` into the container.

```yaml
  - name: build-push-container-image
    volumes:
      - name: docker-config
        secret:
          secretName: docker-config
    container:
      ...
      volumeMounts:
        - name: docker-config
          mountPath: /.docker
      ...
      env:
        - name: DOCKER_CONFIG
          value: /.docker
...
```

Expose the input parameter `platforms`. The value accepts multiple platforms as comma-separated string. Pass down the parameter value to the template, and then assign the value to a command line flag to the `buildctl-daemonless.sh` command. The code snippet below shows the relevant portions of the workflow.

```yaml
spec:
  arguments:
    parameters:
      - name: platforms
        value: linux/amd64,linux/arm64
      ...
  templates:
  - name: build-and-push
    dag:
      tasks:
        - name: container-image
          template: build-push-container-image
          arguments:
            parameters:
              - name: platforms
                value: "{{workflow.parameters.platforms}}"
              ...
  - name: build-push-container-image
    inputs:
      parameters:
        - name: path
        - name: platforms
        - name: image
        - name: hash
    volumes:
      - name: docker-config
        secret:
          secretName: docker-config
    container:
      readinessProbe:
        exec:
          command: [sh, -c, "buildctl debug workers"]
      image: moby/buildkit:v0.12.5-rootless
      volumeMounts:
        - name: work
          mountPath: /work
        - name: docker-config
          mountPath: /.docker
      workingDir: /work/{{inputs.parameters.path}}
      env:
        - name: BUILDKITD_FLAGS
          value: --oci-worker-no-process-sandbox
        - name: DOCKER_CONFIG
          value: /.docker
      command:
        - buildctl-daemonless.sh
      args:
        - build
        - --frontend
        - dockerfile.v0
        - --local
        - context=.
        - --local
        - dockerfile=.
        - --opt
        - platform={{inputs.parameters.platforms}}
        - --output
        - type=image,name=docker.io/{{inputs.parameters.image}}:{{inputs.parameters.hash}},push=true
```

You can determine the Git commit hash with a template, as follows:

```yaml
  - name: short-hash
    inputs:
      parameters:
      - name: revision
    container:
      volumeMounts:
        - mountPath: /work
          name: work
      image: alpine/git:v2.43.0
      workingDir: /work
      command:
      - git
      - rev-parse
      - --short
      - "{{ inputs.parameters.revision }}"
```

The return value of the `git` command can be accessed using the expression `{{ tasks.get-short-hash.outputs.result }}`.