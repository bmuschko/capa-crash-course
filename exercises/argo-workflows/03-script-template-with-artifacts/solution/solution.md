# Solution

Create the bucket and upload the Markdown file into the `convert` folder.

![s3-original-file](./imgs/s3-original-file.png)

Create the Secret object named `aws-cred`. The following command demonstrates the creation of the object using the imperative approach. The access key here is `AKIATEY66NFBTL3YORNY` and the secret key is `4rTLTB266wcw6lLE9BM9ZQFT5`.

```
$ kubectl create secret -n argo generic aws-cred --from-literal=accesskey='AKIATEY66NFBTL3YORNY' --from-literal=secretkey='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'
secret/aws-cred created
```

Next, define the artifact repository for S3 in the form of a ConfigMap representation in the file `aws-artifact-repositories.yaml`. The bucket used here is named `bmuschko-markdown-source-docs` available in the region `us-west-2`.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-artifact-repositories
  namespace: argo
  annotations:
    workflows.argoproj.io/default-artifact-repository: docs-repository
data:
  docs-repository: |
    archiveLogs: false
    s3:
      endpoint: s3.amazonaws.com
      bucket: bmuschko-markdown-source-docs
      region: us-west-2
      accessKeySecret:
        name: aws-cred
        key: accesskey
      secretKeySecret:
        name: aws-cred
        key: secretkey
```

Create the object using the following command.

```
$ kubectl apply -f aws-artifact-repositories.yaml
configmap/aws-artifact-repositories created
```

The workflow could look as shown below. Ensure to define all parameter needed so that their values can be provided when invoking the workflow. The script template needs to create the output directory so that `pandoc` can generated the target file in the output directory.

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: doc-conversion-
spec:
  entrypoint: main

  artifactRepositoryRef:
    configMap: aws-artifact-repositories
    key: docs-repository

  arguments:
    parameters:
      - name: directory
      - name: sourceFile
      - name: targetFile

  templates:
  - name: main
    inputs:
      parameters:
        - name: directory
        - name: sourceFile
        - name: targetFile
      artifacts:
        - name: storage
          path: /mnt
          s3:
            key: "{{ inputs.parameters.directory }}"
    outputs:
      artifacts:
        - name: storage
          path: /mnt/output
          s3:
            key: "{{ inputs.parameters.directory }}/output/{{ inputs.parameters.targetFile }}"

    script:
      image: pandoc/latex:3.1.1.0
      workingDir: /mnt
      command: ["/bin/sh"]
      source: |
        mkdir -p output
        pandoc {{ inputs.parameters.sourceFile }} -o output/{{ inputs.parameters.targetFile }}
```

You can submit the workflow using the following command.

```
$ argo submit -n argo -p directory=convert -p sourceFile=shopping-list.md -p targetFile=shopping-list.pdf --watch doc-conversion.yaml
```

The generated file will become available in the `output` folder.

![s3-generated-file](./imgs/s3-generated-file.png)