Umbraco 4.7 Razor Feature Walkthrough (Gareth Evans)

[Part 1](http://umbraco.com/follow-us/blog-archive/2011/2/23/umbraco-47-razor-feature-walkthrough-%E2%80%93-part-1)

*    Why the new functionality?
*    IEnumerable handling, we can do better
*    Simplistic IEnumerable method support

[Part 2](http://umbraco.com/follow-us/blog-archive/2011/2/24/umbraco-47-razor-feature-walkthrough-%E2%80%93-part-2)

*    Macro Parameters
*    DynamicNode Constructors [string | int | object]
*    DynamicMedia vs Media Properties
*    DynamicMedia ctor string,int,object)
*    DynamicNode .NodeById & .MediaById

[Part 3](http://umbraco.com/follow-us/blog-archive/2011/2/28/umbraco-razor-feature-walkthrough-%E2%80%93-part-3)

*    AncestorOrSelf
*    Ancestors
*    Type Safety
*    XML Properties
*    Custom Extension Methods
*    XPath helper

[Part 4](http://umbraco.com/follow-us/blog-archive/2011/3/1/umbraco-razor-feature-walkthrough-%E2%80%93-part-4)

*    Where with lambda-like syntax
*    OrderBy
*    Extention method

[Part 5](http://umbraco.com/follow-us/blog-archive/2011/3/13/umbraco-razor-feature-walkthrough-part-5)

*    DateTime property support
*    IsProtected & HasAccess
*    Better tree navigation
*    Contains & ContainsAny
*    MediaById & NodeById new overloads
*    DynamicNull
*    IHtmlString

[Part 6](http://umbraco.com/follow-us/blog-archive/2011/9/15/umbraco-razor-feature-walkthrough%E2%80%93part-6.aspx)

*    DateTime property support 
*    DynamicXml fixes and changes
*    New methods on DynamicNode
    - HasProperty
    - Index (or Position)
*    Pluck | Select

[Part 7](http://umbraco.com/follow-us/blog-archive/2011/9/18/umbraco-razor-feature-walkthrough%E2%80%93part-7.aspx)

*    DynamicNode.Where
*    [I]RazorDataTypeModel - Datatype Developers Property Data / Model interface
*    IsHelper
*    IsFirst, IsNotFirst, IsLast, IsNotLast, IsPosition, IsNotPosition, IsModZero, IsNotModZero, IsEven, IsOdd, IsEqual, IsDescendant,IsDescendantOrSelf,IsAncestor,IsAncestorOrSelf

[Part 8](http://umbraco.com/follow-us/blog-archive/2011/9/22/umbraco-razor-feature-walkthrough%E2%80%93part-8.aspx)

*    @Library introduction
*    @Library Mix-Ins/Extensions - Add your own
*    Coalesce, Concatenate and Join
*    NodeById, NodesById
*    @Library.If
*    @Library.ToDynamicXml
*    @Library.Truncate


##Community resources

[Umbraco Razor - Intellisense and Debugging (video by Douglas Robar)](http://youtu.be/NgnKy-VTimU)

##External Razor resources
[Razor Syntax Quick Reference (Phil Haack)](http://haacked.com/archive/2011/01/06/razor-syntax-quick-reference.aspx)

[Inline Razor Syntax Overview (Mike Brind)](http://www.mikesdotnetting.com/Article/153/Inline-Razor-Syntax-Overview)

[Introducing “Razor” – a new view engine for ASP.NET (Scott Guthrie)](http://weblogs.asp.net/scottgu/archive/2010/07/02/introducing-razor.aspx)

##Great libraries that gives your Umbraco Razor a boost

[uQuery](http://ucomponents.codeplex.com/wikipage?title=uQuery) comes with the [uComponents package](http://our.umbraco.org/projects/backoffice-extensions/ucomponents). Just install it and you are ready to go.

[uQL](https://bitbucket.org/ElijahGlover/umbraco.uql/wiki/Home) is a query DSL/Framework for umbraco. It uses the same design pattens as LINQ to query over umbraco's in-memory xml cache. (UQL = umbraco query language)
##Community blogs about Razor

[http://www.aaron-powell.com/umbraco-4-and-razor](http://www.aaron-powell.com/umbraco-4-and-razor)

How to Add Razor Syntax in Umbraco 4.6.1? blog.pbdesk.com/.../razor-support-in-umbraco.html