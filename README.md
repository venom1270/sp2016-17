# Lightweight Q&A Forum

## Goal

The goal of this project is to create a lightweight forum/Q&A site, similar to reddit, 
with the main goal being responsiveness, speed and ease of use.

## Design and target audience

The website is designed to look as simple as possible and to provide an easily understandable flow. It can be used by anybody that likes to discuss different things with other people and supports different display sizes to make browsing more pleasant.

The design is very reddit-like, so if you're familiar with that, you should have no problem navigating and using this website.

## Compatibility issues

The website was tested in latest versions of Google Chrome, Mozilla Firefox, Opera, Internet Exploere and Microsoft Edge. It works flawlessly in Chrome, Firefox and Opera, while Internet Explorer sometimes has some problems with the 'placeholder' attribute. Microsoft Edge doesen't seem to want to connect to the websocket.

## Special functionality
### Comment chaining
You can comment different posts, but you can also comment other comments. This can create long comment-chain discussions.
### Websocket commenting and voting
Each comment and vote has to be approved by the websocket server before it is officialy shown in HTML and later written in the database

## Remarks
Most of the functionallity relies on the backend - database for providing posts, list of categories, login information, filtering etc. and the server generating HTML to be shown. This comes in Phase 2, so most of the HTML is hardcoded and will be improved in the next phase.

The only potentially big problem right now muight be really long comment chains and how to show them in HTML. Some kind of collapsable menu or a whole page dedicated to only showing comment chains is required.





