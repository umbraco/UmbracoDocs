#@RenderPage with Args
<!-- original url: http://our.umbraco.org/wiki/reference/code-snippets/razor-snippets/@renderpage-with-args -->
To output a partial Razor view

To call from another view or template using

    @RenderPage("~/macroScripts/PartialView.cshtml", "Arg 1", "Arg 2")

The file ~/macroScripts/PartialView.cshtml contains the following code

    @{
        <h4>@PageData[0]</h4>
        <p>@PageData[1]</p>
    }

Using the above code snippets the following will be rendered to the page.

    <h4>Arg 1</h4>
    <p>Arg 2</p>

Note the arguments you send into the partial view can be complex data types just remember to cast them to the correct type in your partial view