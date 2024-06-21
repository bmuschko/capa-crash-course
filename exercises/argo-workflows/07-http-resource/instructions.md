# Exercise 8

The development team wants to use data from GitHub to process data from a workflow. You are in charge of making a HTTP request to the RESTful GitHub API to retrieve the name of the branches for a specific repository.

> [!NOTE]
> Every call to the GitHub API needs to be authenticated. Create a [personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens) within your GitHub account.

> [!IMPORTANT]
> Apply the workflow RBAC permissions in the file [`workflow-rbac.yaml`](./workflow-rbac.yaml) to execute the workflow in the namespace `workflow-exec` with the ServiceAccount `workflow-exec-sa`.

1. Perform a HTTPS request using `curl` to the endpoint of the GitHub API for [retrieving a list of branches for a repository](https://docs.github.com/en/rest/branches/branches?apiVersion=2022-11-28#list-branches). Use the [Argo Workflows GitHub repository](https://github.com/argoproj/argo-workflows) for a test and provide the API token you generated for your GitHub account.
2. Create a workflow in the namespace `argo` with the ServiceAccount `app-sa`. The workflow should accept an argument parameter for an API token, as well as repository owner and name.
3. Enhance the workflow by defining a HTTP template that performs the call to the endpoint.
4. Submit the workflow and inspect the execution process.