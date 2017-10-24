# Control Models Generation

Generation of models can be controlled through various C# attributes in the custom files (ie `*.cs`files that are not `*.generated.cs`files) in the models directory.

**Note**: this section is probably slightly confusing - because some attribute behaviors are not precisely specified. Not always sure what happens with compositions etc. There is a current work-in-progress to refactor the attributes so that they make more sense.

## Ignore Content Type

Indicates that a content type with a given alias should be ignored and not generated. The attribute is an assembly attribute.

    [assembly:IgnoreContentType("alias")]

This will cause the content type class to _not_ be generated.

**Note**: must document what happens when it is a parent content type, or when it is part of a composition.

## Ignore Property Type

Indicates that a property type with a given alias should be ignored and not generated. The attribute must decorate the corresponding content type class.

      [IgnorePropertyType("alias")]
      public partial class MyContentType
      { }

This will cause the property to _not_ be generated.

## Implement Content Type

Indicates that a class implements a content type with a given alias. The attribute must decorate the corresponding content type class. Use when alias and class name do not match.

    [ImplementContentType("myDifferentAlias")]
    public partial class MyContentType : PublishedContentModel
    { }

This will cause the content type class to _not_ be generated, since you already implement it.

**Note**: not sure of this. Maybe it's only renaming the generated class.

## Implement Property Type

Indicates that a property implements a property type with a given alias. The attribute must decorate the corresponding property type property. Use when alias and property name do not match.

    public partial class MyContentType
    { 
      [ImplementPropertyType("myDifferentAlias")]
      public int MyProperty { get { return this.GetPropertyValue<int>("myDifferentAlias"); } }
    }

This will cause the property to _not_ be generated, since you already implement it.

## Rename content type

Indicates a different class name for a content type. The attribute is an assembly attribute. Use when alias and class name do not match.

    [assembly:RenameContentType("alias", "ClassName")]

This will cause the content type class to be generated, with the class name "ClassName" instead of "Alias".

## Rename property type

Indicates a different property name for a property type. The attribute must decorate the corresponding content type class. Use when alias and property name do not match.

    [RenamePropertyType("myDifferentAlias", "PropertyName")]
    public partial class MyContentType
    { }

This will cause the property to be generated, with the name "PropertyName" instead of "MyDifferentAlias".

## Models Base Class

Indicates the base class for all models. By default the base class is `PublishedContentModel` but the attribute lets you override it. The attribute is an assembly attribute. The base class should inherit from `PublishedContentModel`.

    [assembly:ModelsBaseClass(typeof (MyOwnBaseClass))]


## Models namespace

Indicates the namespace for all models. Overrides every other namespace that might have been configured. The attribute is an assembly attribute.

    [assembly:ModelsNamespace("MyProject.ContentModels")]


## Models using

Indicates extra "using" statements to be inserted in model files. The models generator already inserts some common "using" statements, plus tries to be clever, but it is not always enough. The attribute is an assembly attribute.

    [assembly:ModelsUsing("MyOtherProject.Some.Other.Thing")]

