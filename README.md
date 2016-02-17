# Vurb
Creates a simple native app. Cards implementation.

You will download JSON and display cards in a UITableView.
The general wireframe is provided below.

Rendering Cards:
● The card json should be retrieved at
https://gist.githubusercontent.com/helloandrewpark/0a407d7c681b833d6b49/raw/5f3936
dd524d32ed03953f616e19740bba920bcd/gistfile1.js

● There are three types of cards: “places”, “movies”, “music” (assume in the future, we will have 20+)

● All cards should have a title and a thumbnail

● In addition, the following special behaviors should exist depending on card type below
the title (specified below)

● The rendering logic should be designed to be scalable so that there can be more types
of cards added in the future.
  Places
● Once the thumbnail image is done downloading, perform 2 image tasks in parallel
○ Task 1) Crop the image to a square
■ Feel free to use  https://github.com/mattgemmell/MGImageUtilities
○ Task 2) Determine the average color of the image
■ Feel free to use (We don’t want to waste your time re­inventing the wheel)
http://www.bobbygeorgescu.com/2011/08/finding­average­color­of­uiimag
e/
○ Once BOTH tasks are completed, set the thumbnail image with the square image and set the card background color to the average color (yes, it won’t be pretty)
cards:
   Movie cards:
■ Do NOT set the thumbnail image before the color is determined
 ● Show an image of the main actor
Music cards:
● Show a button which will open a webpage to the music video
