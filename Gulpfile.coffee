gulp = require 'gulp'
browserify = require 'browserify'
tsify = require 'tsify'
jade = require 'gulp-jade'
rename = require 'gulp-rename'

gulp.task 'build:html', ->
	gulp.src '*.jade'
	.pipe jade()
	.pipe rename (file) -> file.extname = '.html'
	.pipe gulp.dest '.'

gulp.task 'build', ['build:html']

gulp.task 'default', ['build']
