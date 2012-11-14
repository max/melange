# Melange

Melange is a simple wrapper around the [Mixpanel Javascript
API](https://mixpanel.com/docs/integration-libraries/javascript-full-api)
that sends events to Mixpanel based on data attributes you set in the DOM.

Melange currently has a dependency on jQuery, which it uses for DOM selectors, 
defining event handlers, and handling of data attributes.

## Installation

```bash
curl -O https://raw.github.com/max/melange/master/melange.js
```
## Usage

Apply data attributes to the HTML elements you wish to track. You can use any of 
[jQuery's supported events](http://api.jquery.com/category/events/) as triggers.
The only required data attributes are `melange_trigger` and `melange_event_name`.
Any other data attributes with a `melange_` prefix will be included in the event 
metadata.

```html
<a href="/foo" data-melange_trigger='click' data-melange_event_name='clicked the foo'>
  
<img src="unicorn.png" data-melange_trigger='hover' data-melange_event_name='hovered over the unicorn' data-melange_magic_factor="100">

<input type="text" data-melange_trigger='blur' data-melange_event_name='conducted a search'>
```

```javascript
$(function() {
  Melange.init({
    logToConsole: true,
    preventBubbling: false,
    user: window.heroku_oauth_id
  });
});
```

This will generate the following Mixpanel events:

```javascript
mixpanel.track('clicked the foo')
mixpanel.track('hovered over the unicorn', {magic_factor: 100})
mixpanel.track('conducted a search', {input_value: 'current value of input'})
```

Options
-------

**logToConsole**
Set to this `true` to see all events logged in the console.

**preventBubbling**
Sometimes you want to test a link click event, but your browser
redirects to the link before you have a chance to see the results 
logged in the console. To get around this, set `preventBubbling` to `true`.

**user**
Identify a user with a unique ID. If present, user is passed to 
[mixpanel.identify](https://mixpanel.com/docs/integration-libraries/javascript-full-api#identify).

Pro Tips
--------

### Use the Prefix, Luke

Only data attributes with the `melange_` prefix will be included. Any other 
data attributes on the element will be ignored.

### Event Name Formatting

It's recommended that you track events in the format of `action` (in past tense)
`subject`. For example:

* viewed homepage
* clicked button
* opened modal

### jQuery Massages .data()

Note that jQuery attempts to infer the type of your data values.

```javascript
'100' => 100
'2.5' => 2.5
'foo' => 'foo'
```
Depending on your use case, this may or may not be a good thing. See
[this blog post](http://lookfirst.com/2011/12/dont-use-jquery-data-method-use-attr.html) 
for pitfalls.

### Event Data in Form Inputs

If you set up event tracking on an `<input>` element, its value will automatically 
be included in event metadata with the key `input_value`.

### Protect yourself from yourself

If easy to shoot yourself in the foot by forgeting to turn off preventBubbling and 
deploying to production, rendering your site useless. To get around this, make your 
app's `ENVIRONMENT` available on window, then use this config:

```javascript
$(function() {
  Melange.init({
    logToConsole: window.env === 'development',
    preventBubbling: true && window.env === 'development'
  });
});
```

Development
-----------

Use coffee to watch and compile:

```bash
coffee -wc *.coffee
```

License
-------

MIT. Go Nuts.
