using System.Collections.Generic;
using System.Linq;

namespace Umbraco.Docs.Preview.UI.Models
{
    public class NavigationItem
    {
        public string Path { get; set; }
        public string Name { get; set; }

        public List<NavigationItem> Children { get; set; } = new();

        public bool HasChildren => Children.Any();
    }
}
