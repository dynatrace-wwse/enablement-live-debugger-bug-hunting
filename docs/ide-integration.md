--8<-- "snippets/ide-integration.js"

!!! example "🧑‍💻 IDE Integration"
    We love Developers and the developer's experience, we understand that for better and faster Software development a developer does not leave it's IDE. We support JetBrains and VSCode as one of the most common IDE's out there. [Here you can read more about the extensions](https://docs.dynatrace.com/docs/observe/applications-and-microservices/developer-observability/offering-capabilities/ide-integration).


## Launch the IDE from your Browser

On the top left, click on the VS Code menu (the 3 lines), and then click on "Open in VS Code Desktop". This will launch your local VS Code IDE. If you don't have VS Code already installed in your computer, you can download and install it directly from here: [https://code.visualstudio.com/](https://code.visualstudio.com/){ :target="_blank" }

![vscode menu](img/vscode_web_menu.png){ width="300" }

[Download VS Code](https://code.visualstudio.com){ :target="_blank" .md-button }

## Codespaces experience in your full IDE

Now your Codespace is open inside your VS Code IDE. You'll notice that you have now the full IDE experience, you can drag and drop files inside and outside the IDE from your OS and VSCode will automatically add them in the Container that is being managed by your codespace. 

The application is now being exposed and mapped to your localhost. In this case the TODO app is being mapped to port 30100, so you will be able to access it like this: [http://127.0.0.1:30100](http://127.0.0.1:30100){:target="_blank"}

## Get the Dynatrace extension

On the left pane, click on "Extensions", then search for "Dynatrace" > Select "Observability for Developers" and click on "Install in Codespaces"

![vscode menu](img/ide_extension.jpg)


## Select the stage you want to connect

Great! now that you have the Dynatrace extension installed in your IDE, let's configure it. In the extension, click on the "settings wheel" > select "Settings" and click on it.


![vscode menu](img/ide_extension_settings.jpg)

The extension settings will open. You can select the environment you want to connect. 

Dynatrace.....
SSO... support mutliple tenants...


![vscode menu](img/ide_select_environment.png)


## Login Dynatrace SSO

Select tenant you want to connect.



## Set a breakpoint





<div class="grid cards" markdown>
- [Ressources:octicons-arrow-right-24:](resources.md)
</div>
