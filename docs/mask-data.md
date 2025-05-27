--8<-- "snippets/mask-data.js"

## Data masking 
Dynatrace provides you with tools that enable you to meet your data protection and other compliance requirements while still getting value from any data collected by Dynatrace, including the Live Debugger. 


!!! info "Sensitive Data is never sent to the Dynatrace servers"
    Data maksing within the Live Debugger is done on the OneAgent, which means that no personal data will be sent or stored on Dynatrace servers.


## Data masking settings

| Setting      | Description                          |
| :---------- | :----------------------------------- |
| `Rule name`    | A name to identify the masking rule |
| `Rule Active and Order` | You can activate and deactivate a rules on the fly. You can also move a rule up and down among other rules, meaning the first rule that matches the filter will be the one that is effective. |
| `Rule type`  |  |
| `Data replacement`  |  |



## Let's appy a data masking rule to the "title" variable


In your Dynatrace tenant go to:

1. Settings > Observability for Developers > Sensitive data masking
2. Click on "Add rule" and give it a name, e.g. `Title is masked`
3. Rule type,

<div class="grid cards" markdown>
- [Click here to continue :octicons-arrow-right-24:](version-control.md)
</div>
