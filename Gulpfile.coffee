gulp = require 'gulp'
browserify = require 'browserify'
tsify = require 'tsify'
jade = require 'gulp-jade'
less = require 'gulp-less'
rename = require 'gulp-rename'
uglify = require 'gulp-uglify'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'

buildHtml = (locals) ->
	gulp.src '*.jade'
	.pipe jade locals: locals
	.pipe rename (file) -> file.extname = '.html'
	.pipe gulp.dest '.'

gulp.task 'build:html', ->
	buildHtml debug: true

gulp.task 'build:html:release', ->
	buildHtml debug: false

buildJs = ->
	browserify()
	.add 'index.ts'
	.add 'typings/tsd.d.ts'
	.plugin tsify,
		target: 'ES5'
		noImplicitAny: true
	.bundle()
	.pipe source 'index.js'
	.pipe buffer()

gulp.task 'build:js', ->
	buildJs()
	.pipe gulp.dest '.'

gulp.task 'build:js:release', ->
	buildJs()
	.pipe uglify preserveComments: 'license'
	.pipe rename (file) -> file.extname = '.min.js'
	.pipe gulp.dest '.'

gulp.task 'build:css', ->
	gulp.src 'index.less'
	.pipe less()
	.pipe rename (file) -> file.extname = '.css'
	.pipe gulp.dest '.'

gulp.task 'build', ['build:html', 'build:js', 'build:css']

gulp.task 'release', ['build:html:release', 'build:js:release', 'build:css']

gulp.task 'default', ['build']
