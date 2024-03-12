# Exercise 2

This exercise asks you to set up a webhook that triggers the creation of a Pod.

1. Setup an event source for a webhook in the namespace `argo-events`. The webhook should define a single event configuration that runs an HTTP server on port 12000 with the endpoint `pod-creation`.
2. Create a sensor that will create a Pod using the container image `alpine:3.19.1` when triggered. Parse a single parameter from the request body and map it to the name `message`. The container should execute the message using the `echo` command. Assign the service account name `argo-events-sa` to the sensor.
3. Expose the event source Pod via port forwarding to consume HTTP requests on port `12000`.
4. Perform a HTTP call to the endpoint to trigger the creation of a Pod. Find the Pod and inspect its logs.