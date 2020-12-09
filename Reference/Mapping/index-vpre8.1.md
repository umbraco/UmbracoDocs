---
versionTo: 8.1.0
---

# Object Mapping in Umbraco

Often in code there is a need to 'map' one object's properties to another type of object, and the 'type of objects' are not related by inheritance or interface. (Think database layer object, passing information to a presentation layer ViewModel etc). In these circumstances, it can save time and provide consistency to consolidate the logic to map between the options into one set of 'Mapping' rules.
Prior to Umbraco 8.1 mapping was handled by an external dependency AutoMapper, to improve startup times and reduce external dependencies it has been replaced in 8.1.0+ by a simpler Umbraco specific implementation called UmbracoMapper.
