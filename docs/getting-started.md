--8<-- "snippets/getting-started.js"
--8<-- "snippets/grail-requirements.md"

## 1. Dynatrace Tenant Setup
You will need a Dynatrace SaaS tenant with a DPS pricing model and the 'Code Monitoring' rate card should be associated with it. In addition the application needs to be monitored with Dynatrace FullStack mode. The application runtime: Java, NodeJS.

### 1.1 Enable Observability for Developers

- Go to Settings > Preferences > OneAgent features.
     - Enable the Java Live-Debugger, Node.js Live-Debugger, or both, depending on your needs.
- Go to Settings > Observability for Developers > Enable Observability for Developers

[More information can be found here](https://docs.dynatrace.com/docs/observe/applications-and-microservices/developer-observability/do-enable)


### 1.2 Set IAM Polocies 
We take security very seriously. So let's create a policy to set user-level Live Debugging breakpoints. 

We need two policies for your user to be able to set breakpoints and to read snapshots. 
For this we go to **Account Management > Identity & Access management > + Policy **

Set breakpoints
```bash
ALLOW storage.application.snapshots:set;
```

Read Snapshopts
```bash
ALLOW storage.application.snapshots:read;
ALLOW storage:buckets:read WHERE storage:table-name = "application.snapshots";
```

The policy should look like this:

![DevOps Policy](img/devops_policy.png)

Then we bind it to a user group. In this case since we are admins, let's bind the policy to the Admin group. Notice that the created policy is for an Admin and also for a Developer. Since we allow to `read` and `set` breakpoints but also to `manage` breakpoints [which is explained here](https://docs.dynatrace.com/docs/observe/applications-and-microservices/developer-observability/offering-capabilities/additional-settings#manage-breakpoints).



Go to Group Management > Select Admin Group > + Permission  (and bind the policy)
![Bind Group](img/bind_group.png)

Like this you have the fine control to give your developers, SRE teams and whoever you want to set breakpoints and read the snapshots. For more granular access [please continue reading here](https://docs.dynatrace.com/docs/observe/applications-and-microservices/developer-observability/offering-capabilities/setup) 


### 1.3 Enable Live Debugger ActiveGate module

Now we need to enable the [Live Debugger ActiveGate module](https://docs.dynatrace.com/docs/shortlink/do-setup#enable-live-debugging-in-environment-activegate-module):

```yaml
#Set debugging_enabled to true in the custom.properties file.
activeGate:
    customProperties:
      value: |
        [debugging]
        debugging_enabled = true
```
This is already set up for you in the codespaces automatically in the [Dynakube.yaml](https://github.com/dynatrace-wwse/enablement-live-debugger-bug-hunting/blob/main/.devcontainer/yaml/dynakube-skel.yaml) file so no need to restart the ActiveGate.


## 2. Getting the permissions for monitoring the Kubernetes Cluster with Dynatrace
This codespace has everything automated for you so you can focus on what matters which in this enablement is to learn about the Live Debugging capabilities of the Dynatrace Platform.  You'll need two tokens:

1. Operator Token
2. Ingest Token 

We will get this two very easy from the Kubernetes App. 

## 2.1. Get the Operator Token and the Ingest Token from the Kubernetes App
1. Open the Kubernetes App (CTRL + K then type Kubernetes for fast access)
2. Select the + Add cluster button
3. Scroll down to the section Install Dynatrace Operator 
4. Click on generate Token for the 'Dynatrace Operator' and save it to your Notepad
5. Click on generate Token for the 'Data Ingest Token' and save it to your Notepad
6. You can close the Kubernetes App, we don't need it, we just needed the tokens.


![Kubernetes Tokens](img/k8s_tokens.png)



!!! tip "Let's launch the Codespace"
    Now we are ready to launch the Codespace! You'll need your tenant and the two tokens previuosly gathered from above. When you enter the tenant please enter it without the 'apps' part, for production tenants eg. abc123 for live -> https://abc123.live.dynatrace.com and for sprint -> https://abc123.sprint.dynatracelabs.com no apps in the URL.


<div class="grid cards" markdown>
- [Let's launch Codespaces:octicons-arrow-right-24:](codespaces.md)
</div>
