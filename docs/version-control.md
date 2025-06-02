--8<-- "snippets/version-control.js"

!!! Example "Automate the Version Control integration for all your environments"
    With environment variables it's easy to point each deployed application in every stage and kubernetes cluster to the right vesion control, branch and commit.


## Integrate with your version control
When debugging within a remote environment, you need to know exactly what source code it is executing. The Live Debugger integrates with your source control provider to fetch the correct source code for every environment, wheter is development, staging or production environment. Using environment variables within your CI/CD processes, makes it easy and accurate to point to the specific commit, branch and version control for each deployed application. 


| ENV Variable      | Description                          |
| :---------- | :----------------------------------- |
| `DT_LIVEDEBUGGER_COMMIT`    | String that indicates your git commit |
| `DT_LIVEDEBUGGER_REMOTE_ORIGIN` | String that indicates your git remote origin. <br>For multiple sources, use the environment variable DT_LIVEDEBUGGER_SOURCES to <br> initialize the SDK with information about the sources used in your application. |
| `DT_LIVEDEBUGGER_SOURCES`  | is a semicolon-separated list of source control repository and revision information, joined by #.<br> For example: <br> DT_LIVEDEBUGGER_SOURCES=https://github.com/myorg/MyRepo#abc123;https://github.com/otherorg/OtherRepo#xyz789. |


[More information in the official documentation page.](https://docs.dynatrace.com/docs/observe/applications-and-microservices/developer-observability/offering-capabilities/additional-settings#integrate-with-your-version-control)


## Let's automate the version control information

We recommend to automate the version control information within the build and deployment process of the application. 



- Show the bash script


- copy&paste command to execute it


- open the Live Debugger


- Verify pod id with pod, version control is automatically selected.



<div class="grid cards" markdown>
- [Click here to continue :octicons-arrow-right-24:](grail-and-dql.md)
</div>
