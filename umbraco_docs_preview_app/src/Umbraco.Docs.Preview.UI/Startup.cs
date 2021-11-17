using System.IO;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.FileProviders;
using Microsoft.Extensions.Hosting;
using Umbraco.Docs.Preview.UI.MiscellaneousOurStuff;
using Umbraco.Docs.Preview.UI.Services;

namespace Umbraco.Docs.Preview.UI
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddMvc();
            services.AddHttpContextAccessor();
            services.AddSingleton<IDocumentService, DocumentService>();
            services.AddSingleton<IMarkdownService, MarkdownService>();
            services.AddSingleton<DocumentationUpdater>();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Error");
            }

            var tree = app.ApplicationServices.GetRequiredService<DocumentationUpdater>().BuildSitemap();

            AddImageFileProviders(tree, app);

            app.UseStaticFiles();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }

        private void AddImageFileProviders(DocumentationUpdater.SiteMapItem folder, IApplicationBuilder app)
        {
            var path = Path.Combine(folder.PhysicalPath, "images");
            var requestPath = $"/documentation/{folder.Path}/images".Replace("//", "/"); // Hack for root UmbracoDocs folder

            if (Directory.Exists(path))
            {
                app.UseStaticFiles(new StaticFileOptions
                {
                    FileProvider = new PhysicalFileProvider(path),
                    RequestPath = requestPath
                });
            }

            foreach (var child in folder.Directories)
            {
                AddImageFileProviders(child, app);
            }
        }
    }
}
