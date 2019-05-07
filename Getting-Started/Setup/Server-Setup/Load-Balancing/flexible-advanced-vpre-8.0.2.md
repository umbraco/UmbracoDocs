---
versionFrom: 8.0.0
versionTo: 8.0.2
---

# Controlling load balancing instructions of the DatabaseServerMessenger in 8.0.0

While this worked in v7, it was not possible to control the options of the DatabaseServerMessenger using the `DatabaseServerMessengerOptions` in 8.0.0 and 8.0.1.  This has been fixed in v 8.0.2.

Due to the new Composer setup, you'll need to create an [Composer](../../../../Implementation/Composing/index.md) to set the messenger options.

```csharp
public void Compose(Composition composition)
{
    composition.SetDatabaseServerMessengerOptions(factory =>
    {
        var options = DatabaseServerRegistrarAndMessengerComposer.GetDefaultOptions(factory);
        options.DaysToRetainInstructions = 10;
        options.MaxProcessingInstructionCount = 1000;
        options.ThrottleSeconds = 25;
        options.PruneThrottleSeconds = 60;
        return options;
    });
}
```

For more information, see at the current documentation.