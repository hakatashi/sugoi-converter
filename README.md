# Sugoi Converter

[travis-image]: https://travis-ci.org/hakatashi/sugoi-converter.svg?branch=master
[travis-url]: https://travis-ci.org/hakatashi/sugoi-converter
[coveralls-image]: https://coveralls.io/repos/hakatashi/sugoi-converter/badge.svg?branch=master&service=github
[coveralls-url]: https://coveralls.io/github/hakatashi/sugoi-converter?branch=master

[![Travis Status][travis-image]][travis-url]
[![Coverage Status][coveralls-image]][coveralls-url]

[link]: https://hakatashi.github.io/sugoi-converter/
[build-history]: https://docs.google.com/spreadsheets/d/1pqdn8BEOKRdc3cx6eYxOdZr5LNwGGINAVg0anHLUBZQ/edit?usp=sharing

For your ease of programming, hacking, CTFing... Say “[Sugoi!](https://en.wiktionary.org/wiki/%E3%81%99%E3%81%94%E3%81%84)”

**[Link][link]**

[![Screenshot](assets/screenshot.png)][link]

[The History of Build Information (such as file size of assets)][build-history]

## Used Technologies

This project uses various new technologies for my JavaScript study. Here is the list:

### Scripting and libraries

* [CoffeeScript](http://coffeescript.org/)
* [TypeScript](http://www.typescriptlang.org/)
    - ~~[TSD](http://definitelytyped.org/tsd/)~~ → Upgraded to [Typings](https://github.com/typings/typings)
* [core-js](https://github.com/zloirock/core-js) - ported from [Babel](https://babeljs.io/)
* ~~[jQuery](https://jquery.com/)~~ → Migrated to [zepto.js](http://zeptojs.com/)

### Build System

* [Gulp](http://gulpjs.com/)
    - [UglifyJS](http://lisperator.net/uglifyjs/)
    - [clean-css](https://github.com/jakubpawlowicz/clean-css)
* [Browserify](http://browserify.org/)
    - [Coffeeify](https://github.com/jnordberg/coffeeify)
	- [tsify](https://www.npmjs.com/package/tsify)

### Static assets

* [Jade](http://jade-lang.com/)
* [LESS](http://less-ja.studiomohawk.com/)
    - [Pure.css](http://purecss.io/)

### Unit Testing

* [Mochify](https://www.npmjs.com/package/mochify)
    - [Mocha](http://mochajs.org/)
    - [Chai](http://chaijs.com/)
* [Istanbul](https://github.com/gotwarlost/istanbul)

### Maintenance

* [Greenkeeper](https://greenkeeper.io/)

## Bug Hunt

These bugs were found along the development of this repository.

* [Is it valid not to throw error in querystring.encode? - nodejs/node](https://github.com/nodejs/node/issues/3702)
* [Node: Fix punycode.ucs2.decode return type - DefinitelyTyped/DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped/pull/6587)
* [Fix fatal error of surrogte pair - feross/buffer](https://github.com/feross/buffer/pull/82)
