---
versionFrom: 8.0.0
---

# Creating a custom Database table

In Umbraco it is possible to add custom database tables to your site if you want to store additional data. Below you will find an example that sets up a table using by registering a [component in a composer](../../Implementation/Composing/index.md), and then creating a migration plan and running the plan to add a database table. The end result looks like this:

![Database result of a migration](images/db-table.PNG)

```csharp
using Umbraco.Core.Logging;
using Umbraco.Core.Composing;
using Umbraco.Core.Migrations;
using Umbraco.Core.Migrations.Upgrade;
using Umbraco.Core.Scoping;
using Umbraco.Core.Services;
using NPoco;
using Umbraco.Core.Persistence.DatabaseAnnotations;

namespace Umbraco.Web.UI
{
    public class BlogCommentsComposer : ComponentComposer<BlogCommentsComponent>
    {
    }

    public class BlogCommentsComponent : IComponent
    {
        private IScopeProvider _scopeProvider;
        private IMigrationBuilder _migrationBuilder;
        private IKeyValueService _keyValueService;
        private ILogger _logger;

        public BlogCommentsComponent(IScopeProvider scopeProvider, IMigrationBuilder migrationBuilder, IKeyValueService keyValueService, ILogger logger)
        {
            _scopeProvider = scopeProvider;
            _migrationBuilder = migrationBuilder;
            _keyValueService = keyValueService;
            _logger = logger;
        }

        public void Initialize()
        {
            // Create a migration plan for a specific project/feature
            // We can then track that latest migration state/step for this project/feature
            var migrationPlan = new MigrationPlan("BlogComments");

            // This is the steps we need to take
            // Each step in the migration adds a unique value
            migrationPlan.From(string.Empty)
                .To<AddCommentsTable>("blogcomments-db");

            // Go and upgrade our site (Will check if it needs to do the work or not)
            // Based on the current/latest step
            var upgrader = new Upgrader(migrationPlan);
            upgrader.Execute(_scopeProvider, _migrationBuilder, _keyValueService, _logger);
        }

        public void Terminate()
        {
        }
    }

    public class AddCommentsTable : MigrationBase
    {
        public AddCommentsTable(IMigrationContext context) : base(context)
        {
        }

        public override void Migrate()
        {
            Logger.Debug<AddCommentsTable>("Running migration {MigrationStep}", "AddCommentsTable");

            // Lots of methods available in the MigrationBase class - discover with this.
            if (TableExists("BlogComments") == false)
            {
                Create.Table<BlogComment>().Do();
            }
            else
            {
                Logger.Debug<AddCommentsTable>("The database table {DbTable} already exists, skipping", "BlogComments");
            }
        }
    }

    [TableName("BlogComments")]
    [PrimaryKey("Id", AutoIncrement = true)]
    [ExplicitColumns]
    public class BlogComment
    {
        [Column("Id")]
        public int Id { get; set; }

        [Column("BlogPostUmbracoId")]
        public int BlogPostUmbracoId { get; set; }

        [Column("Name")]
        public string Name { get; set; }

        [Column("Email")]
        public string Email { get; set; }

        [Column("Website")]
        public string Website { get; set; }

        [Column("Message")]
        [SpecialDbType(SpecialDbTypes.NTEXT)]
        public string Message { get; set; }
    }
}
```
