# Contributing to Hacktoberfest

We [have general contribution guidelines available](../README.md) for Umbraco-CMS, the backoffice project, the UI library and documentation. 

Specificially for Hacktoberfest, we have a lot more things you can get involved in!

## Umbraco 15 release candidate testing

One of our main focus areas for 2024 is to deeply test out the major new features of Umbraco v15. The [release candidate for the upcoming Umbraco v15 is available now](https://umbraco.com/blog/umbraco-15-release-candidate/) and we encourage you to test the main new features, namely:

- The new Rich Text Editor (RTE)
  - Migrating existing RTEs to the new RTE datatype
  - Working with the new RTE
  - Extending the new RTE
- Lazy-loaded content, which is replacing the main caching mechanism
  - Upgrading existing sites and making sure everything still works on the frontend
  - If you have any custom routing or controllers in place, do they still work as expected
  - Try out the new `ISeedKeyProvider`, `IDocumentServices` and `IDistributedCache`
- Block-level variants
  - Making sure all of your existing blocks work after an upgrade
  - If you have a large block-based site, it is interesting to see if the upgrade doesn't take too long
  - Add variants to your existing or new blocks and start using them: edit, save, publish, etc

Once you have done a round of thorough testing, make sure to [report any issues on the tracker](https://github.com/umbraco/Umbraco-CMS/issues/new?assignees=&labels=type/bug&labels=affected/v14&template=01_bug_report.yml&title=v15RC1) as usual.

### Making it count for Hacktoberfest

We really appreciate your help in testing this release. Make sure to describe to us in a bit of detail what you've tried, let us know a bit about the scale of project you're testing on, etc.

If everything "just" worked (🤞) then describe that as well! Let us know exactly what you focused on that worked well.

You can do this by heading to the [HacktoberfestActivityLog](https://github.com/umbraco/HacktoberfestActivityLog) repository and adding your name to the list in the "Low code/no code" section.

An example of a participation entry is:

`- 2024-10-04 - Paula Philips - Umbraco 15 Release Candidate testing - Details in the PR description`

In the description of the pull request to get your name added, put your test results as described above and link to any issues you've created if things didn't work as expected.

{% hint style="info" %}
This would be a great use of [the `Draft` pull request feature on GitHub](https://github.blog/news-insights/product-news/introducing-draft-pull-requests/), so you can work on testing and keep updating the description with your test results until you're done and ready to submit your final PR. 
{% endhint %}


## Packages

Packages are back on the menu - and yes, they also count as a contribution to Umbraco!

Here are some specific details on this:

* Only contributions made to open-source Umbraco packages added to the Hacktoberfest Package repo list counts
* Follow the contribution guidelines provided by the package creator
* Look for the "help wanted" label on the issue tracker associated with the package you want to help out with
* Read much more about how this works, and guidelines on adding your own package repo to [the list on the Umbraco Packages Hacktoberfest homepage](https://github.com/umbraco/Umbraco.Packages/tree/main/Hacktoberfest). 

Note: Package contributions eligibility for swag  differ slightly from those used for all contributions. Read more on the **[Packages Hacktoberfest guidelines](https://github.com/umbraco/Umbraco.Packages/tree/main/Hacktoberfest) to learn more about how a contribution is marked as "swag-eligible"**.

### Creating a brand-new package

Publishing a brand new package to [the Umbraco Marketplace](https://marketplace.umbraco.com/) will also count towards both DigitalOcean's and Umbraco's Hacktoberfest contributions ⭐🤩

Packages for Umbraco 14 and up are eligible by default, even if the equivalent package already exists for older Umbraco versions.

[Check out Lee Kelleher’s list of potential new package ideas!](https://leekelleher.github.io/umbraco-package-ideas/)

## Low-code / no-code contributions 

Back, by popular demand, we will also be rewarding contributions that are either low-code and more importantly: no-code!

Eligible contributions according to [the Hacktoberfest guidelines](https://hacktoberfest.com/about/#low-or-non-code) include:

* Verifying documentation
* Copy editing
* User experience testing
* Talks or presentations
* Blog posts
* Podcasts
* Case studies
* Organizing Hacktoberfest events

We [have set up a special GitHub repository](https://github.com/umbraco/HacktoberfestActivityLog) for you to record your contributions that are not a pull request.

In order to record your journey of verifying documentation (like related blog post(s) in October, events organized), edit the README.md file and add your activity at the end in the recommended format and submit that as a pull request. We’ll take it from there!

{% hint style="info" %}
The teams at [Skrift](https://skrift.io/write/) and [24 days in Umbraco](https://24days.in/umbraco-cms/write-for-us/) are always looking for new articles. Finish your application October to make it count! We'll ask the Skrift/24 days teams to verify your application to write an article.
{% endhint %}

## Sponsor an Umbraco-related GitHub repository

To appreciate people who maintain open-source projects for the Umbraco ecosystem, an easy way to help contribute is to give them some money! We’d suggest you have a look at your favorite packages and see if their repo/maintainer is accepting sponsorship. 

We suggest you scroll through the [list of topics on GitHub, filtered by Umbraco](https://github.com/topics/umbraco), and see if your favorite packages/authors are open to sponsorship. Look for the heart icon.

![Screenshot that shows the Sponsor heart option](images/hacktoberfest_screenshot.png)

If you're in doubt if your chosen sponsorship would count, then feel free to first [create an issue on the Hacktoberfest Activity Log repository](https://github.com/umbraco/HacktoberfestActivityLog/issues), or ask [on Discord](https://discord.umbraco.com/) in the #contributing channel.

Umbraco HQ [sponsors 4 different projects at the moment](https://community.umbraco.com/the-community-blog/oss-sponsorship-initiative/), at $100 per month. These are excellent projects that could always use more sponsorships, but make sure to also consider other repositories, there are many great ones out there!

And the good news is: yes, you will be able to earn Umbraco swag, proportionate to your sponsorship amount. 

## How we judge a Hacktoberfest-eligible contribution

We use [the Hacktoberfest participation rules](https://hacktoberfest.com/participation/) to qualify, so any contributions that do not follow these standards will also not count towards Umbraco swag. These rules are to ensure we get quality contributions and that the right efforts get rewarded 🙌

If you’re contributing to one of the open-source Umbraco Packages, check [the Packages Hacktoberfest guidelines](https://github.com/umbraco/Umbraco.Packages/tree/main/Hacktoberfest) to learn more about how a contribution is marked as "swag-eligible".

## Any questions?

In order to help you succeed we at HQ are trying to be available as much as possible during the month of October on Discord in the [#contributing](https://discord-chats.umbraco.com/c/contributing) channel.

Whether you need some inspiration, guidance, help getting things to build, and so on - we’re there to support and guide you, together with the [Core Collaborators team](https://community.umbraco.com/community-teams/the-core-collaborators/).

![Screenshot that shows the Discord #contributing channel](images/discord_contributing.png)

So come join us and the other 1500+ people already on the [Umbraco Discord server](https://umbra.co/discorddocs)!

Happy Hacktoberfest! 🎃
