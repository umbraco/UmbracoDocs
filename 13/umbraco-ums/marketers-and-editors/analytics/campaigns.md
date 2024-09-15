In the campaigns tab of the uMarketingSuite you will find all the analytics data of campaigns. Campaigns are created by using utm-parameters, that you probably already use for the tracking of your campaigns.

Campaigns are automatically tracked by using utm-parameters, that you may be already using for your marketing campaigns. You can add 5 different parameters to your url:

- **utm\_source**: Identify the advertiser, site, publication, etc. that is sending traffic to your property, for example: google, newsletter4, billboard.
- **utm\_medium**: The advertising or marketing medium, for example: cpc, banner, email newsletter.
- **utm\_campaign**: The individual campaign name, slogan, promo code, etc. for a product.
- **utm\_term**: Identify paid search keywords. If you're manually tagging paid keyword campaigns, you should also use utm\_term to specify the keyword.
- **utm\_content**: Used to differentiate similar content, or links within the same ad. For example, if you have two call-to-action links within the same email message, you can use utm\_content and set different values for each so you can tell which version is more effective.

Each parameter must be paired with a value that you assign. Each parameter-value pair then contains campaign-related information.

For example, if you want to link from a newsletter to the pricing-page of the umarketingsuite.com, you can use the following parameters:

- **utm\_source** =  newsletter-july-2021 to identify that this visitor came from this specific newsletter
- **utm\_medium** = newsletter to show that the medium was a newsletter
- **utm\_campaign** = more\_signups because that newsletter was part of a bigger campaign
- **utm\_content** = bottom\_button to identify a specific link in the newsletter

If you want to use these parameters you'll need to setup the url as:

[https://www.umarketingsuite.com/pricing/?utm_source=newsletter-july-2021&utm_medium=newsletter&utm_campaign=more_signups&utm_content=bottom_button](https://www.umarketingsuite.com/pricing/?utm_source=newsletter-july-2021&amp;utm_medium=newsletter&amp;utm_campaign=more_signups&amp;utm_content=bottom_button)

## The report

In the report you will find all campaigns (that is setup by the parameter **utm\_campaign**):

![]()

You see how many visitors came to the website via this campaign url and how many sessions that created. You also see how often a goal was triggered for visitors via this campaign.

You can then drill down into a specific campaign to see the source & medium of the campaign as well:

![]()