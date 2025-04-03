# Getting Started
<!-- 
TODO: verify the js payload on all pages and setup a tenant for monitoring enablement.

 -->
--8<-- "snippets/bizevent-getting-started.js"
--8<-- "snippets/grail-requirements.md"

## 1. Dynatrace Tenant Setup
You will need a Dynatrace SaaS tenant with a DPS pricing model and the 'Code Monitoring' rate card should be associated with it. In addition the application needs to be monitored with Dynatrace FullStack mode. The application runtime: Java, NodeJS.


## 2. Getting the permissions for monitoring the Kubernetes Cluster with Dynatrace
This codespace has everything automated for you so you can focus on what matters which in this enablement is to learn about the Live Debugging capabilities of the Dynatrace Platform.  You'll need two tokens:

1. Operator Token
2. Ingest Token 

We will get this two very easy from the Kubernetes App. 

## 2.1. Get the Operator Token and the Ingest Token from the Kubernetes App
1. Open the Kubernetes App
2. Select the + Add cluster button
3. Scroll down to the section Install Dynatrace Operator 
4. Click on generate Token for the 'Dynatrace Operator' and save it to your Notepad
5. Click on generate Token for the 'Data Ingest Token' and save it to your Notepad
6. You can close the Kubernetes App, we don't need it, we just needed the tokens.

!!! tip "Add img K8s App"
    TODO:add image of K8s App




!!! tip "Let's launch the Codespace"
    Now we are ready to launch the Codespace! You'll need your tenant and the two tokens previuosly gathered from above. When you enter the tenant please enter it without the 'apps' part, for production tenants eg. abc123 for live -> https://abc123.live.dynatrace.com and for sprint -> https://abc123.sprint.dynatracelabs.com no apps in the URL.

## 3. Launch Codespace

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/dynatrace-wwse/enablement-live-debugger-bug-hunting){target="_blank"}


## 3.1 Machine Type & Variables

As a machine type select 4-core and enter your credentials within the following variables:

- DT_TENANT
- DT_OPERATOR_TOKEN
- DT_INGEST_TOKEN


## 4. Grab a Coffee
We know your time is very valuable. This codespace takes around 6 minutes to be fully operational. A local Kubernetes ([kind](https://kind.sigs.k8s.io/){target="_blank"}) cluster monitored by Dynatrace will be configured and in it a sample application, the TODO app will be deployed. To make your experience best, we are also installing and configuring tools like:

**k9s kubectl helm node jq python3 gh**


## 3. Explore What Has Been Deployed

Your Codespace has now deployed the following resources:

- A local Kubernetes ([kind](https://kind.sigs.k8s.io/){target="_blank"}) cluster monitored by Dynatrace, with some pre-deployed apps
  that will be used later in the demo.

<!-- 
- Three [Dynatrace workflows](https://www.dynatrace.com/platform/workflows/){target="_blank"}:
    - **Predict Kubernetes Resource Usage**: This workflow predicts the future resource usage of Kubernetes workloads
      using Davis predictive AI. If a workload is likely to exceed its resource quotas, the workflow creates a custom
      Davis event with all necessary information.
    - **Commit Davis Suggestions**: Triggered by the predictive workflow's events, this workflow uses Davis CoPilot and
      the GitHub for Workflows app to create pull requests for remediation suggestions.
    - **React to Resource Saturation**: If the prediction actually misses some resource spikes, this workflow will get
      alerted via the automatically created Davis problem and will trigger the prediction workflow to immediately react
      and create a pull request. This workflow is disabled by default to avoid unwanted triggers of the prediction
      workflow.
- A [Dynatrace notebook](https://www.dynatrace.com/platform/notebooks/){target="_blank"} that provides a more in-depth overview of how
  the deployed workflows work.
- A [Dynatrace dashboard](https://www.dynatrace.com/platform/dashboards/){target="_blank"} that shows a summary of all predictions and 
  their accuracy.
  -->


TODO: Create some context on Bugs, Some Breaking Points stuff, elevate the talk for Developers.


## 7. Troubleshooting

TODO: Troubleshooting steps on the codespace, also add tips and tricks, show that the functions are loaded in the shell.


<div class="grid cards" markdown>
- [Click Here to Continue :octicons-arrow-right-24:](bughunt.md)
</div>
