# Exercise 5

John is a developer and finds himself writing certain templates over and over again when switching between projects. He's currently working on a Go project, and has to check out code from Git in order to build it. Help him to extract the `checkout` template into a WorkflowTemplate.

1. Inspect the existing workflow in [`go-build-workflow.yaml`](./go-build-workflow.yaml). Identify the template named `checkout`.
2. Extract the `checkout` template into a WorkflowTemplate so that it becomes reusable. Register the WorkflowTemplate with Argo Workflows. From the command line, list the WorkflowTemplate object.
3. Modify the existing workflow so that it uses the logic from the WorkflowTemplate to clone a Git repository.
4. Execute the workflow.