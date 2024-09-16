# Videos

The uMarketingSuite gathers video statistics for the following types of videos:

- HTML5 videos (i.e. videos provided via the &lt;video&gt; element)
- Embedded YouTube videos
    - **IMPORTANT** Make sure the embed URL contains **?enablejsapi=1** as part of its full URL to enable tracking. So the "src" property of the iframe should be something like: [https://www.youtube.com/embed/&lt;CODE&gt;?enablejsapi=1](https://www.youtube.com/embed/&lt;CODE&gt;?enablejsapi=1)
    - Note we load the [https://www.youtube.com/iframe_api](https://www.youtube.com/iframe_api) for this purpose.
- Embedded Vimeo videos
    - Note we load [https://player.vimeo.com/api/player.js](https://player.vimeo.com/api/player.js) for this purpose.

For these videos the following information is gathered:

- Video URL
- Video name
    - For YouTube and Vimeo the name can be retrieved.
    - For HTML5 we record the file name.
- Total Time Watched (seconds)
- Total Percentage Watched
- In Viewport
    - True if the video was in the user's viewport
- Watched
    - True if the video played for at least 1 second

Apart from the metadata above we also track actions performed on the video player. These actions are:

- Autoplay
    - If the video was started automatically
- Play
    - When the video starts playing
- Pause
    - When the video is paused
- Resume
    - When the video is resumed from a Paused state
- Ended
    - When the video is ended
- Seek
    - When a seek operation is performed

## The report

By collecting this data we can visualize different reports about the videos. You will find these reports in the Analytics subsection and the tab Videos.

![]()

Here you find all videos that are displayed on the website. Per video you can see

- how often the video was played
- the total playtime of the video
- the average video playtime of the video

From here you can also drilldown in the video to see more details about that video. You can do that by clicking on the video itself:

![]()

For this video you see how often the video was started (in this case by auto play), how often the video was paused, how often it was resumed and how often visitors seeked in the video.