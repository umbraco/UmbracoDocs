#Canonical Urls in Razor

Razor syntax for CanonicalUrl for Umbraco site:

Ref.: [blog.pbdesk.com/.../...or-umbraco-using-razor.html](http://blog.pbdesk.com/2011/01/canonical-url-for-umbraco-using-razor.html)

    @using umbraco
    @using System
    @{var canonicalUrl= String.Empty;}
    @if(umbraco.library.RequestServerVariables("HTTP_HOST").ToLower().StartsWith("www")) {
      canonicalUrl = string.Concat("http://", umbraco.library.RequestServerVariables("HTTP_HOST"), Model.Url);
    } else {
      canonicalUrl = string.Concat("http://www.", umbraco.library.RequestServerVariables("HTTP_HOST"), Model.Url);
    }
    <link rel="canonical" href="@cononicalUrl" />