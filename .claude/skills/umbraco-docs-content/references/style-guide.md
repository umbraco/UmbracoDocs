# Style Guide Reference

Full style rules for Umbraco documentation content.

## Text Formatting Rules

### No Punctuation in Headings
Do not end headings with `.`, `?`, or `:`.

### No Double Spacing
Never use more than one consecutive space in text.

### Lists
- **Ordered lists**: for sequential steps. Start each item with the action verb. Max two actions per item.
- **Unordered lists**: for non-sequential sets (options, notes, criteria).
- Start list items with capital letters (exception: camelCase method names in inline code).
- Use sub-items for additional detail.

## Language Rules

### Second Person
Address the reader as "you". Do not use "the user", "we", or passive constructions.

- Bad: "The user should add the Document Type by clicking the Add button."
- Good: "You can add the Document Type by clicking..."

### Present Tense and Active Voice
Use present tense for general behavior.

- Bad: "The Document Type was added..."
- Good: "The Document Type is added..."

### No Editorializing
Avoid these words (they are subjective and unhelpful):
- simple, simply, just, easily, actually, obviously, of course, straightforward

These can usually be removed entirely without rephrasing.

### Sentence Length
Keep sentences under 25 words. Shorter sentences improve clarity for technical content.

### No Vague References
Do not use "it" or "this" to refer to something mentioned earlier. Name the thing explicitly.

- Bad: "This can now be configured."
- Good: "The Document Type can now be configured."

## Terms and Names

### Umbraco Terms (use exact casing)
- Umbraco (always capitalized)
- backoffice (lowercase)
- Document Type (two words, both capitalized)
- Umbraco Forms
- Content Node
- Media Type
- Member Type
- Data Type
- Property Editor
- Template
- Macro

### Discouraged Terms
- "blacklist" → use "deny list"
- "whitelist" → use "allow list"
- "master" (for branches) → use "main"

### Acronyms
Define every acronym on first use in each article:
- **Content Delivery Network (CDN)** — then use CDN
- **YSOD: Yellow Screen of Death** — colon syntax also works

### Capitalization of Languages and Brands
- Always capitalize: HTML, CSS, JSON, XML, YAML
- Write in full: JavaScript (not JS), TypeScript (not TS)
- Capitalize brands: Microsoft, Slack, GitHub, NuGet, Visual Studio

## Link Text
Use the title of the linked article as the link text.

- Bad: "Learn more [here](url)."
- Good: "Learn more in the [Defining Content](url) article."
