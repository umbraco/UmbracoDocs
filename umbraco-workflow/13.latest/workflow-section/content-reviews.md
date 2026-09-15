# Content Reviews

Content reviews is a tool that allows content editors to keep their content up-to-date. **Content reviews** adds a new dashboard to the **Workflow** section. By default, Content reviews are disabled and can be enabled from **Content reviews Settings** in the **Workflow** section.

![Enable Content Reviews](<../.gitbook/assets/Enable-content-reviews (1).png>)

## Video overview

{% embed url="https://youtu.be/mnSL7nrn10o" %}
Watch this video to learn how to use the Content Review feature in Umbraco Workflow
{% endembed %}

## Content Reviews Dashboard

The Content reviews Dashboard provides an overview of the expired content. The dashboard displays a table containing the following details:

* Page name/Node with the Language variant
* Next review due date
* Last reviewed date
* Review period in days
* Review group

![Content Reviews Dashboard](<../.gitbook/assets/Content-review-dashboard (1).png>)

Selecting a content node takes you to the content node in the **Content** section where you can see the Content review banner. The Content review banner is displayed only when the node has passed its review date. Also, the review banner is displayed only to users assigned as reviewers for the node. For more information, see the [Content Reviews Permissions](content-reviews.md#content-review-permissions) section

![Content Review Message Banner](<../.gitbook/assets/content-review-message-banner (1).png>)

Clicking on **Mark as reviewed** allows the review group member to mark the content as reviewed. Optionally, the review group member can also set the next review date on the content node. The next review date must fall inside the review period set in the **Content Reviews Settings**.

![Content Review Date](<../.gitbook/assets/content-review-date (1).png>)

You can also **Filter** the Dashboard records based on the Node, Group Email, Next review due date, Last reviewed date, and Expired review Status.

![Content Reviews Filters](<../.gitbook/assets/content-reviews-filter (1).png>)

Additionally, you can adjust the total number of records displayed on a page.

![Content Reviews PageSize](<../.gitbook/assets/content-reviews-pagesize (1).png>)

## Content Reviews Settings

The Content reviews Settings tab provides a range of settings for configuring email notifications, review period days, reminder days, and so on. Using Content reviews, all content has a default review period.

### General Settings

You can configure the **General** Settings from the **Workflow** section in the **Content reviews** menu. The following settings are available:

![General settings](<../.gitbook/assets/content-reviews-general-settings (1).png>)

* **Enable content reviews** - Enable this setting if you wish to remind users to review their content. By default, this option is disabled.
* **Send notifications** - Enable this setting to send email notification to approval groups when content requires review.
* **Treat saving as a review?** - Enable this setting to reset the review date when content is saved. Saving a content node recalculates the review date, using the review period assigned to the content node, its Document Type, or the default Review period value. If disabled, content must be explicitly reviewed via the review banner displayed on the content item.
* **Review period (days)** - The default number of days between content reviews.
* **Reminder threshold (days)** - Determines how many days prior to the review date the Workflow should notify editors of required reviews. By default, the number of days is set to 1.

### Content Review Permissions

You can configure specific review groups to review designated content nodes or Document Types. The review group responsible for reviewing content is determined by the workflow configuration. This means a site with workflow already configured can leverage the existing permissions model for assigning content review responsibilities. By default, content reviews are assigned to the approval group defined in the first stage of the workflow.

Content review permissions can be set at the node or Document Type level, both of which take precedence over any existing Workflow permissions. Permissions are assigned to user roles or groups within each workflow stage. For example:

* Internal Reviewers: Users assigned to roles like _Editors_ or _Content Managers_ may have permissions to review content during the Internal Review stage. They ensure content quality, compliance with standards, and provide feedback for improvements before the content is published.
* External Reviewers: External reviewers are users who are invited to participate in the content review process but do not have Backoffice access. Their main role is to provide feedback or suggest changes based on their expertise or stake in the content being published. This feedback is not managed by Workflow.

![Content review permissions](../.gitbook/assets/Content-review-permissions-v13.png)

The current permissions for a content node are displayed in the **Workflow** content app on the **Configuration** tab.

![Workflow Content App - Configuration tab](<../.gitbook/assets/workflow-content-app-configuration (1).png>)

### Content Item and Document Type Reviews

You can configure content reviews for individual content nodes or for all nodes of a given Document Type. For both Content Item and Document Type Reviews, the following settings are available:

* **Language** - Allows you to specify which language version of the content is being reviewed.
* **Exclude from review** - Enable this setting to ignore the specific content node (or all content nodes of this Document Type) when determining nodes to review.
* **Review period (days)** - The review period in days between required reviews.
* **Review group** - The group responsible for reviewing the content node. Can contain more than one group.
* **External reviewers** - Assign email addresses for reviewers without CMS access. Feedback from external reviewers is not managed by Workflow.

{% hint style="info" %}
When reviews are enabled or any changes to content review settings are saved, Workflow determines the review status. It assesses all the content needing review and provides this data in the Content reviews Dashboard. For large sites, or on the first run, this may take a few seconds to complete.
{% endhint %}

#### Content Item Reviews

To add a content item review, follow these steps:

1. Go to the **Workflow** section.
2. Go to the **Settings** tab in the **Content reviews** menu.
3.  Click **Add** in the **Content item reviews** section.

    ![Content Item Reviews](<../.gitbook/assets/content-item-reviews (1).png>)
4.  Select **Content node** to add to the Content item reviews section.

    ![Select Content Node](<../.gitbook/assets/content-item-reviews-select-content (1).png>)
5. Select the **Language** from the drop-down.
6. _\[Optional]_ Enable **Exclude from Review** if you wish to exclude this content node from content review. If you enable this setting, skip to step 12.
7. Enter the **Review period** in days.
8. Click **Add** to add the **Review Group**.
9. Select an **approval group**.
10. Click Submit.
11. _\[Optional]_ Enter a user in the **External reviewers** field. For example: `john.doe@workflow.com`.

    ![Edit Content Item Review Settings](../.gitbook/assets/Content-review-permissions-v13.png)
12. Click Submit.
13. Click **Save Settings**.

To Edit a content item review, click **Edit** and update the settings as per your requirement.

To remove a content item review, click **Remove**.

#### Document Type Reviews

To add a Document Type review, follow these steps:

1. Go to the **Workflow** section.
2. Go to the **Settings** tab in the **Content reviews** menu.
3.  Click **Add** in the **Document-type reviews** section.

    ![Document Type reviews](<../.gitbook/assets/document-type-reviews (1).png>)
4.  Select **Content type** to add to the Document-type reviews section.

    ![Select Content Type](<../.gitbook/assets/document-type-reviews-select-content (1).png>)
5. Select the **Language** from the drop-down.
6. _\[Optional_] Enable **Exclude from Review** if you wish to exclude this Document-type from content review. If you enable this setting, skip to step 12.
7. Enter the **Review period** in days.
8. Click **Add** to add the **Review Group**.
9. Select an **approval group**.
10. Click Submit.
11. _\[Optional]_ Enter a user in the **External reviewers** field. For example: `john.doe@workflow.com`.

    ![Add Document Type Review Settings](../.gitbook/assets/document-type-review-settings-v13.png)
12. Click Submit.
13. Click **Save Settings**.

To Edit a Document-type review, click **Edit** and update the settings as per your requirement.

To remove a Document-type review, click **Remove**.

## Content Review Notifications

Content review notifications use the email template available at `~/Views/Partials/WorkflowEmails/ContentReviews.cshtml`, which can be customized as required. For example to add a corporate branding or send customized messages.

To add templates for other languages:

1. Go to the `~/Views/Partials/WorkflowEmails/` folder.
2. Copy the required template and paste it into the same folder.
3. Append the culture code to the file name prefixed with an underscore.

For example:

* **Default approval request template:** `~/Views/Partials/WorkflowEmails/ContentReviews.cshtml`
* **Danish approval request template:** `~/Views/Partials/WorkflowEmails/ContentReviews_da-DK.cshtml`
