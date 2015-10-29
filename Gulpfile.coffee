gulp = require 'gulp'
browserify = require 'browserify'
tsify = require 'tsify'
jade = require 'gulp-jade'
rename = require 'gulp-rename'
source = require 'vinyl-source-stream'
glob = require 'glob'

gulp.task 'build:html', ->
	gulp.src '*.jade'
	.pipe jade()
	.pipe rename (file) -> file.extname = '.html'
	.pipe gulp.dest '.'

gulp.task 'build:js', ->
	browserify()
	.add 'index.ts'
	.add glob.sync 'typings/**/*.d.ts'
	.plugin tsify
	.bundle()
	.pipe source 'index.js'
	.pipe gulp.dest '.'

gulp.task 'build', ['build:html', 'build:js']

gulp.task 'default', ['build']
