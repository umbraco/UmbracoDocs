# Structure

When you a contributing to the Umbraco documentation it can be useful to know how we structure directories, files and images.

In this article you will get an overview of the file structure as well as a few best-practices for naming files.

## By product and topic

The overall structure of the Umbraco documenation is divided by product. Each Umbraco product has its own directories with articles and images.

Diving one step deeper, each individual topic is contained in its own directory.

Each directory must have a `README.md` file which will act as a landing page for that directory. If images are used, these must be in an `images` directory next to the `.md` file referencing them using relative paths.

* `/topic` *(directory)*
  * `README.md`
  * `another-page.md`
  * `/images` *(directory)*
    * `images.png`
  * `/subtopic` *(directory)*
    * `README.md`
    * `topic.md`
    * `another-topic.md`
    * `/images` *(directory)*

## File names

All file and directory names need to be small-caps in order to be synced properly with GitBook.

If an article is not a landing page, we recommend using the title of the article as the file name.

## Images

Images are stored and linked using relative paths to .md pages, and should by convention always be in an `images` directory. To add an image to `/documentation/reference/partials/renderviewpage.md` you link it like so:

```markdown
![My Image Alt Text](images/img.png)
```

And store the image as `/documentation/reference/partials/images/img.png`

Images can have a maximum width of **800px**. Please always try to use the most efficient compression, `gif` or `png`. No `bmp`, `tiff` or `swf` (Flash).
