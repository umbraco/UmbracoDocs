#DynamicNode IsHelpers
The IsHelper methods are a set of extension methods for DynamicNode to 'help' perform quick conditional queries against DynamicNode nodes in a collection.

IsHelper methods all work the same, and have 3 overloads. They're basically ternary operators, but work a little nicer in that they're easy to embed in properties and quicker to write as you don't need so many brackets to make Razor understand them.

The general use IsHelper is to allow you to dynamically inject class names and style attributes onto your html elements, based on their position within the collection you are iterating. You can use this for a variety of things such as alternating row colours or fixing the margin/padding on the first/last item etc.

---

##How to use
To use an IsHelper you need to be iterating over a collection of DynamicNodes.

	<ul>
	@foreach(var item in Model.Children){
		<li class="@item.IsFirst("first","not-first")">@item.Name</li>
	}
	</ul>
	
Is helpers work like ternary operators. The example above uses the `.IsFirst()` Ishelper method. The first parameter is the value we want it to return if the condition returns true, and the second, optional value, is the value we want to return if the condition evaluates to false.

IsHelpers can also return simple boolean values.

	@if(item.IsFirst()){
		<p>Extra info for this item</p>
	}

---

##IsHelper Methods

###.IsFirst([string valueIfTrue][,string valueIfFalse])
Test if current node is the first item in the collection

###.IsNotFirst([string valueIfTrue][,string valueIfFalse])
Test if current node is not first item in the collection

###.IsLast([string valueIfTrue][,string valueIfFalse])
Test if current node is the last item in the collection

###.IsNotLast([string valueIfTrue][,string valueIfFalse])
Test if current node is not the last item in the collection

###.IsPosition(int index[,string valueIfTrue][,string valueIfFalse])
Test if current node is at the specified index in the collection

###.IsNotPosition(int index[,string valueIfTrue][,string valueIfFalse])
Test if current node is not at the specified index in the collection

###.IsModZero([string valueIfTrue][,string valueIfFalse])
Test if current node position evenly dividable (modulus) by a given number

###.IsNotModZero([string valueIfTrue][,string valueIfFalse])
Test if current node position is not evenly dividable (modulus) by a given number


###.IsEven([string valueIfTrue][,string valueIfFalse])
Test if current node position is even

###.IsOdd([string valueIfTrue][,string valueIfFalse])
Test if current node position is odd

###.IsEqual(DynamicNode otherNode[,string valueIfTrue][,string valueIfFalse])
Tests if the current node in your iteration is equivalent (by Id) to another node

###.IsDescendant(DynamicNode otherNode[,string valueIfTrue][,string valueIfFalse])
Tests if the current node in your iteration is a descendant of another node

###.IsDescendantOrSelf(DynamicNode otherNode[,string valueIfTrue][,string valueIfFalse])
Tests if the current node in your iteration is a descendant of another node or is the node

###.IsAncestor(DynamicNode otherNode[,string valueIfTrue][,string valueIfFalse])
Tests if the current node in your iteration is an ancestor of another node

###.IsAncestorOrSelf(DynamicNode otherNode[,string valueIfTrue][,string valueIfFalse])
Tests if the current node in your iteration is an ancestor of another node or is the node