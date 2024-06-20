# Solution

First, try to perform the HTTP call via `curl`. The following command show the command in action. Make sure to provide a valid API token. The request limits the number of results to 2 items using the `per_page` parameter.

```
$ curl -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer <YOUR-TOKEN>" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/argoproj/argo-workflows/branches\?per_page\=2'
[
  {
    "name": "1.0",
    "commit": {
      "sha": "7b05a76061f1232aa639e7e08b7a230779ab5700",
      "url": "https://api.github.com/repos/argoproj/argo-workflows/commits/7b05a76061f1232aa639e7e08b7a230779ab5700"
    },
    "protected": true
  },
  {
    "name": "1.1",
    "commit": {
      "sha": "7a896427ad2b312b41b4fb4e6daa48d860f0aecd",
      "url": "https://api.github.com/repos/argoproj/argo-workflows/commits/7a896427ad2b312b41b4fb4e6daa48d860f0aecd"
    },
    "protected": true
  }
]
```

Crafting the workflow could look as shown in the YAML manifest below. The arguments `owner` and `repo` assign a default values and point to the Argo Workflows GitHub repository. You can override them when submitting the workflow.

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: github-
  namespace: playground
spec:
  arguments:
    parameters:
    - name: apiToken
    - name: owner
      value: argoproj
    - name: repo
      value: argo-workflows
  serviceAccountName: playground-sa
  entrypoint: main
  templates:
  - name: main
    inputs:
      parameters:
      - name: apiToken
      - name: owner
      - name: repo
    http:
      url: "https://api.github.com/repos/{{inputs.parameters.owner}}/{{inputs.parameters.repo}}/branches?per_page=2"
      method: "GET"
      headers:
      - name: "Accept"
        value: "application/vnd.github+json"
      - name: "Authorization"
        value: "Bearer {{inputs.parameters.apiToken}}"
      - name: "X-GitHub-Api-Version"
        value: "2022-11-28"
      successCondition: response.statusCode == 200
```

Submit the workflow with the following command.

```
$ argo submit -p apiToken=<YOUR-TOKEN> --watch -n playground github-simple-workflow.yaml
```