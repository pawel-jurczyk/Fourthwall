# iOS Coding Challenge

Hi 👋! Thank you for taking the time to participate in this coding challenge to develop a simple iOS app. The following task is going to show us your skills, experience, and coding style. Please remember that you can use as any tools, libraries, etc. that you feel comfortable with. 

## What to expect?

We expect that it will take ~3 hours to complete this exercise. While you're welcome to take as much extra time as you'd like to clean up or improve the codebase, it's not required. If there's something that you would have done in a "real" production environment, feel free to add details to your `README`, so we can better understand what next steps that you'd take.

## What we are looking for?

* **Treat it like production code**. Develop your software in the same way that you would for any code that is intended to be deployed to production. These may be toy exercises, but we really would like to get an idea of how you build code on a day-to-day basis. This may include following architecture patterns, providing sample unit tests, creating detailed commit messages, etc.
* **Keep it simple**. You don't have a lot of time, so focus on what is important. Please document the choices that you've made in your project `README`.

## How to submit?

You can do this however you see fit - you can email us a tarball, a pointer to download your code from somewhere or just a link to a source control repository. Make sure your submission includes a small `README`, documenting any assumptions, simplifications and/or choices you made, as well as a short description of how to run the code and/or tests. Finally, to help us review your code, please split your commit history in sensible chunks.

## Challenge

Develop an application, which will allow users to browse a list images from [Lorem Picsum](https://picsum.photos/). The application should be available for devices with iOS 13 or newer. We expect that this application will support the following:

1. When the app launches, a loading 🌀 state should appear during the initial loading stage (e.g. API requests are made)
2. Once you've retrieved a valid list of images, we should display each in a 2-column grid of square images
3. Whenever the user taps on an image, a new screen (image detail) should appear with the following: A larger view of the image and the name of the image's author.
4. Additionally, the image detail screen should also include a button, which will allow the user to share the image with other apps (e.g. email, SMS, etc)

As time permits, consider some of the following:

* Adding basic test coverage
* Handling error states if the API fails to load
* Adding support for a caching layer to speed up cold launches
* Adding support for paging, so we automatically load more images as the user scrolls up/down
* Using different amounts of grid columns, based on if the phone is in portrait vs landscape mode
* Using different amounts of grid columns, based on if we're using an iPhone or iPad
* Adding support for anything else that you think would be useful...

Please document any assumptions and design decisions in a project `README.md`.

### APIs

As part of this exercise, we anticipate that you'll need to access some of the following APIs:

* To list the first page of images: `GET https://picsum.photos/v2/list`. The API will return 30 items per page by default. To request another page, use the `?page` parameter.
* To fetch a specific image: `https://picsum.photos/200?image={IMAGE_ID}`
* And potentially any others as defined [on their home page](https://picsum.photos/)

_Please note these APIs are all public, so you do not need to provide an API access key_

## F.A.Q.

1. _Is it OK to share your solutions publicly?_
Yes, the questions are not prescriptive, the process and discussion around the code is the valuable part. You do the work, you own the code. Given we are asking you to give up your time, it is entirely reasonable for you to keep and use your solution as you see fit.

2. _Should I do X?_
For any value of X, it is up to you, we intentionally leave the problem a little open-ended and will leave it up to you to provide us with what you see as important. Just remember the rough time frame of the project. If it is going to take you a couple of days, it isn't essential.

3. _Something is ambiguous, and I don't know what to do?_
The first thing is: don't get stuck. We really don't want to trip you up intentionally, we are just attempting to see how you approach problems. That said, there are intentional ambiguities in the specifications, mainly to see how you fill in those gaps, and how you make design choices.

## What's next?

Once you're done, send us a confirmation email. After you submit your code, we will contact you to discuss next steps. 

Good luck! 💪