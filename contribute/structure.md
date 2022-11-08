# Structure

When you a contributing to the Umbraco documentation it can be useful to know how we structure directories, files and images.

In this article you will get an overview of the file structure as well as a few best-practices for naming files.

For the Umbraco documentation project, each individual topic is contained in its own folder.

Each folder must have an `index.md` file which links to the individual sub-pages. If images are used, these must be in `images` folders next to the .md file referencing them using relative paths.

* `topic`
  * `images`
    * `images.png`
  * `Subtopic`
    * `images`
    * `index.md`
  * `index.md`
  * `other-page.md`

  ## Images

Images are stored and linked using relative paths to .md pages, and should by convention always be in an `images` folder. To add an image to `/documentation/reference/partials/renderviewpage.md` you link it like so:

```markdown
![My Image Alt Text](images/img.png)
```

And store the image as `/documentation/reference/partials/images/img.png`

Images can have a maximum width of **800px**. Please always try to use the most efficient compression, `gif` or `png`. No `bmp`, `tiff` or `swf` (Flash).