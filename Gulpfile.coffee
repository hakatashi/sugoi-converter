gulp = require 'gulp'
tsify = require 'tsify'
mochify = require 'mochify'
coffeeify = require 'coffeeify'
browserify = require 'browserify'
jade = require 'gulp-jade'
less = require 'gulp-less'
rename = require 'gulp-rename'
uglify = require 'gulp-uglify'
connect = require 'gulp-connect'
minifyCss = require 'gulp-minify-css'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
istanbul = require 'mochify-istanbul'

buildHtml = (locals) ->
	gulp.src '*.jade'
	.pipe jade locals: locals
	.pipe rename (file) -> file.extname = '.html'
	.pipe gulp.dest '.'

gulp.task 'build:html', ->
	buildHtml debug: true
	.pipe connect.reload()

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
	.pipe connect.reload()

gulp.task 'build:js:release', ->
	buildJs()
	.pipe uglify preserveComments: 'license'
	.pipe rename (file) -> file.extname = '.min.js'
	.pipe gulp.dest '.'

buildCss = ->
	gulp.src 'index.less'
	.pipe less()
	.pipe rename (file) -> file.extname = '.css'
	.pipe gulp.dest '.'

gulp.task 'build:css', ->
	buildCss()
	.pipe connect.reload()

gulp.task 'build:css:release', ->
	buildCss()
	.pipe minifyCss()
	.pipe rename (file) -> file.extname = '.min.css'
	.pipe gulp.dest '.'

gulp.task 'connect', ->
	connect.server
		root: '.'
		livereload: true
		port: 35158

gulp.task 'watch', ->
	gulp.watch ['*.ts', 'src/*.ts'], ['build:js']
	gulp.watch '*.less', ['build:css']
	gulp.watch '*.jade', ['build:html']
	return

gulp.task 'mochify:phantom', ['build'], ->
	mochify './test/index.js',
		reporter: 'spec'
		extension: ['.ts', '.coffee']
		transform: ['coffeeify']
	.add 'typings/tsd.d.ts'
	.plugin tsify,
		target: 'ES5'
		noImplicitAny: true
	.bundle()

gulp.task 'mochify:node', ['build'], ->
	mochify './test/index.js',
		reporter: 'spec'
		node: true
		extension: ['.ts', '.coffee']
		transform: ['coffeeify']
	.add 'typings/tsd.d.ts'
	.plugin tsify,
		target: 'ES5'
		noImplicitAny: true
	.bundle()

gulp.task 'mochify:cover', ->
	mochify './test/index.js',
		node: true
		extension: ['.ts', '.coffee']
		transform: ['coffeeify']
	.add 'typings/tsd.d.ts'
	.plugin tsify,
		target: 'ES5'
		noImplicitAny: true
	.plugin istanbul,
		report: ['text', 'text-summary', 'lcov']
		dir: './coverage'
	.bundle()

gulp.task 'build', ['build:html', 'build:js', 'build:css']
gulp.task 'release', ['build:html:release', 'build:js:release', 'build:css:release']
gulp.task 'serve', ['connect', 'watch']
gulp.task 'test', ['mochify:node', 'mochify:phantom']

gulp.task 'default', ['test']
