gulp = require 'gulp'
browserify = require 'browserify'
tsify = require 'tsify'
jade = require 'gulp-jade'
rename = require 'gulp-rename'
source = require 'vinyl-source-stream'

buildHtml = (locals) ->
	gulp.src '*.jade'
	.pipe jade locals: locals
	.pipe rename (file) -> file.extname = '.html'
	.pipe gulp.dest '.'

gulp.task 'build:html', ->
	buildHtml debug: true

gulp.task 'build:html:release', ->
	buildHtml debug: false

gulp.task 'build:js', ->
	browserify()
	.add 'index.ts'
	.add 'typings/tsd.d.ts'
	.plugin tsify,
		target: 'ES5'
		noImplicitAny: true
	.bundle()
	.pipe source 'index.js'
	.pipe gulp.dest '.'

gulp.task 'build', ['build:html', 'build:js']

gulp.task 'default', ['build']
