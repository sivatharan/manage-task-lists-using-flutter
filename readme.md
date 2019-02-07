# Slider
- Author: Kurtis Kemple
- Email: kurtiskemple@gmail.com
- Date: 9/25/2013

> If you would like to contribute to this module please see instructions at bottom of readme file.

Mod Slider is a content slider plugin that allows for the simple creation of sliders for images or html. It is object oriented and requires jQuery 1.8 or later. (You can use lower versions but you must replace the .on() method with legacy event handlers such as .click() and .load() )

## Usage

To use the slider module you must instantiate a new instance of the object and pass in an object with your settings. The only setting you must set is the selector of the element you want to call the slider on. All other options are just that...optional.

The slider is very simple to use, the children of the DOM element you call the slider on will be each slide, it can be images, DIVs, LIs, or any other element. It is completely up to you on how you style it. Example instantiation of a slider:

```html
<div id="home-carousel">
    <div class="home-carousel-slide">
        <h1>Post Title</h1>
        <p>Post Excerpt</p>
    </div>
    <div class="home-carousel-slide">
        <h1>Post Title</h1>
        <p>Post Excerpt</p>
    </div>
    <div class="home-carousel-slide">
        <h1>Post Title</h1>
        <p>Post Excerpt</p>
    </div>
</div>
```

```javascript
var homeCarousel = new Slider({
    contentElement: '#home-carousel'
});
```

This will give you a fully functional slider without the need to do anything else, however, there are a lot of options you can set.

## Options

```javascript
var homeCarousel = new Slider({
    contentElement: '#home-carousel', //the element to create the slider on
    duration: 5000, //the duration a slide stays before rotating in milliseconds
    speed: 600, //the amount of time it takes for the slide to transition from one to another in milliseconds
    transition: 'slide', //the type of transition to use, the options are 'slide' and 'fade'
    reverse: false, //the direction the slider should operate in
    auto: true, //whether or not the slider should run automagically
    startIndex: 1, //the slide to start on, 1 based number
    showButtons: false, //whether or not to show dot navigation,styling is up to developer
    showArrows: false, //whether or not to display navigation arrows at left and right side of slider, styling is up to developer
    leftArrowNavClass: '', //the class to add to left arrow nav if using arrows
    rightArrowNavClass: '', //the class to add to right arrow nav if using arrows
    dotNavClass: '', //the class to add to each LI in the dot navigation
    initialized: function() {}, //the callback to run when the slider is initialized, this fires before the JS even constructs the slider (after all variables are set and DOM elements retrieved )
    buildComplete: function() {}, //fires after the slider is constructed but right before it runs if set to auto
    beforeSlide: function() {}, //fires right before a slide change
    afterSlide: function() {}, //fires right after the slide has changed
    itemsAppended: function() {}, //fires after the .append() method is ran
    itemsRemoved: function() {}, //fires after the .remove() method is ran
    paused: function() {}, //fires after the .pause() method is ran
    reset: function() {}, //fires after the .reset() method is ran
    resumed: function() {}, //fires after the .start() method is ran
    updated: function() {}, //fires after the .update() method is ran
});
```

These are the currently available options for the slider.

## Methods

#### .prev()
This method transitions the slider back one slide
Example:

```javascript
$( '.some-element' ).on( 'click', homeCarousel.prev );
```

or

```javascript
$( '.some-element' ).on( 'click', function() {
    homeCarousel.prev();
});
```
___

#### .next()
This method transitions the slider forward one slide
Example:

```javascript
$( '.some-element' ).on( 'click', homeCarousel.next );
```

or

```javascript
$( '.some-element' ).on( 'click', function() {
    homeCarousel.next();
});
```
___

#### .index()
This method will transition to a specific slide ( 1 based number )
Example:

```javascript
//Go to slide 4
$( '.some-element' ).on( 'click', function() {
    homeCarousel.index( 4 );
});
```
___

#### .pause()
This method will pause the slider if it is set to auto
Example:

```javascript
$( '.some-element' ).on( 'click', homeCarousel.pause );
```

or

```javascript
$( '.some-element' ).on( 'click', function() {
    homeCarousel.pause();
});
```
___

#### .resume()
This method will resume the slider if it has been paused and it is set to auto
Example:

```javascript
$( '.some-element' ).on( 'click', homeCarousel.resume );
```

or

```javascript
$( '.some-element' ).on( 'click', function() {
    homeCarousel.resume();
});
```
___

#### .reset()
This method will bring the slider back to slide 1 and start it if auto is set
Example:

```javascript
$( '.some-element' ).on( 'click', homeCarousel.reset );
```

or

```javascript
$( '.some-element' ).on( 'click', function() {
    homeCarousel.reset();
});
```
___


#### .append()
This method allows you to add new slides to the slider, they should match previous slides in style and structure and after they are appended the slider will rebuild with the new slides included
Example:

```javascript
var slide = $( <div/>, {
    'class': 'home-carousel-slide'
})
.append( '<h1>Post Title</h1>')
.append( '<p>Post Excerpt</p>');

homeCarousel.append( slide );
```
___

#### .remove()
This method allows you to remove slides from the slider. It takes two parameters, startIndex and number of slides
Example:

```javascript
//remove 2nd and 3rd slide
homeCarousel.remove(2, 2) //start at second slide, remove two slides
```
___

#### .update()
This method allows you to update the settings of the slider, the only option you can't update is the transition type due to the diffent construction needed for the two different types of transitions
Example:

```javascript
homeCarousel.update({
    duration: 3000,
    speed: 400,
    afterSlide: function() {
        console.log( "Slide Complete" );
    }
});
```
___

### Contributing To The Project
If you would like to contribute to this module:
- Clone the repo
- Check out develop branch
- Create new branch with feature name
- Make changes
- Push new branch to origin
- Add a new merge request with a detailed explaination of the changes you made

Once the changes are reviewed they will either be added or the merge request will be closed.









