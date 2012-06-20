#Render Razor scripts for emails and more
If you need to render a razor script for use in for example a email body you can use the RazorMacroEngine in this way:

Add the following file in App_Code

    using umbraco.cms.businesslogic.macro;
    using umbraco.MacroEngines;
    using System.Collections.Generic;

    public class RenderRazor
    {
        public static string Render(string razorScript = "", string macroScriptFileName = "", int nodeId = 0, Dictionary<string, string> macroParameters = null)
        {
            var macroEngine = new RazorMacroEngine();
            var macro = new MacroModel();

            macro.ScriptCode = razorScript;
            macro.ScriptLanguage = "cshtml";
            macro.ScriptName = macroScriptFileName;
    
            var node = new umbraco.NodeFactory.Node(nodeId);

            if (macroParameters != null)
                foreach (var param in macroParameters)
                {
                    macro.Properties.Add(new MacroPropertyModel(param.Key, param.Value));
                }

            return macroEngine.Execute(macro, new umbraco.NodeFactory.Node(nodeId));
        }

        public static string RenderRazorScriptString(string razorScript, int nodeId, Dictionary<string, string> macroParameters = null)
        {
            return Render(razorScript, "", nodeId, macroParameters);
        }

        public static string RenderRazorScriptFile(string macroScriptFileName, int nodeId, Dictionary<string, string> macroParameters = null)
        {
            return Render("", macroScriptFileName, nodeId, macroParameters);
        }
    }

There's two helper functions, one for render a existing script file and one for a script string. Usage:

Sample 1

    var scr = "Time is @DateTime.Now";
    var contextNodeId = 1100;
    var resultingString = RenderRazor.RenderRazorScriptString(scr,contextNodeId);

Sample 2

    var dict = new Dictionary<string, string>();
    dict.Add("Recipient","Jonas");
    var contextNodeId = 1100;
    var emailBodyText = RenderRazor.RenderRazorScriptFile("EmailTemplate.cshtml",contextNodeId,dict);
    umbraco.library.SendMail(fromAddress,toAddress,"Email from homepage",emailBodyText,true);

Where dict is a dictionary of values that's sent to the razor script Parameter collection:

    <h1>@Parameter.Recipient</h1>