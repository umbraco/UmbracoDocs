# Configuration
With Umbraco Forms it's possible to customize the functionality with various configuration values.

## Editing configuration values
The configuration for Umbraco Forms can be changed by modifing the XML based config file found at `/App_Plugins/UmbracoForms/UmbracoForms.config`

### EnableAntiForgeryToken
This setting needs to be a `True` or `False` value and will enable ASP.NET Anti Forgery Token and we recommend that you enable this and set this to true. Due to older versions of Umbraco Forms not containg this, it has become an optional config setting and due to upgrade reasons we do not automatically set this to true for you.

If you do set this to `True` then you need to add `@Html.AntiForgeryToken()` to your forms, the default template for Forms can be found in `~/Views/Partials/Forms/Form.cshtml` and should have `@Html.AntiForgeryToken()` in the `@using (Html.BeginUmbracoForm [...]` block.