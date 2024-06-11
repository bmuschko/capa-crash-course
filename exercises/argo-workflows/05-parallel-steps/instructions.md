# Exercise 5

A coworker wrote a workflow that renders a single string to standard output in a container. You want to enhance the logic by writing multiple messages in parallel.

1. Inspect the existing workflow in the file [`echo.yaml`](./echo.yaml).
2. Change the workflow by introducing a step template. The step template should render three different messages in parallel using `withItems`.
3. Execute the workflow and inspect the container logs, as well as the workflow visualization.
4. Change the implementation of the workflow to use `withParam`. Provide a JSON array to feed in the data as a workflow argument.
5. Verify that the result is the same compared to the usage of `withItems`.