pkg = require './package.json'
gulp = require 'gulp'
tsify = require 'tsify'
mochify = require 'mochify'
coffeeify = require 'coffeeify'
browserify = require 'browserify'
pug = require 'gulp-pug'
less = require 'gulp-less'
rename = require 'gulp-rename'
uglify = require 'gulp-uglify'
connect = require 'gulp-connect'
cleanCss = require 'gulp-clean-css'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
istanbul = require 'mochify-istanbul'

TYPEFILES = [
	'lib.d.ts'
]

buildHtml = (locals) ->
	locals.pkg = pkg

	gulp.src '*.pug'
	.pipe pug locals: locals
	.pipe rename (file) -> file.extname = '.html'
	.pipe gulp.dest 'dist'

gulp.task 'build:html', ->
	buildHtml debug: true
	.pipe connect.reload()

gulp.task 'build:html:release', ->
	buildHtml debug: false

buildJs = ->
	browserify()
	.add 'index.ts'
	.add TYPEFILES
	.plugin tsify,
		target: 'ES5'
		noImplicitAny: true
	.transform 'browserify-shim'
	.bundle()
	.pipe source 'index.js'
	.pipe buffer()

gulp.task 'build:js', ->
	buildJs()
	.pipe gulp.dest 'dist'
	.pipe connect.reload()

gulp.task 'build:js:release', ->
	buildJs()
	.pipe uglify()
	.pipe rename (file) -> file.extname = '.min.js'
	.pipe gulp.dest 'dist'

buildCss = ->
	gulp.src 'index.less'
	.pipe less()
	.pipe rename (file) -> file.extname = '.css'
	.pipe gulp.dest 'dist'

gulp.task 'build:css', ->
	buildCss()
	.pipe connect.reload()

gulp.task 'build:css:release', ->
	buildCss()
	.pipe cleanCss()
	.pipe rename (file) -> file.extname = '.min.css'
	.pipe gulp.dest 'dist'

gulp.task 'connect', ->
	connect.server
		root: 'dist'
		livereload: true
		port: 35158

gulp.task 'watch', ->
	gulp.watch ['*.ts', 'src/*.ts'], gulp.series 'build:js'
	gulp.watch '*.less', gulp.series 'build:css'
	gulp.watch '*.pug', gulp.series 'build:html'
	return

gulp.task 'mochify:phantom', (done) ->
	mochify './test/index.js',
		reporter: 'spec'
		extension: ['.ts', '.coffee']
		transform: ['coffeeify']
	.add TYPEFILES
	.plugin tsify,
		target: 'ES5'
		noImplicitAny: true
	.on 'error', (error) -> done error
	.on 'end', -> done()
	.bundle()

gulp.task 'mochify:node', (done) ->
	mochify './test/index.js',
		reporter: 'spec'
		node: true
		extension: ['.ts', '.coffee']
		transform: ['coffeeify']
	.add TYPEFILES
	.plugin tsify,
		target: 'ES5'
		noImplicitAny: true
	.on 'error', (error) -> done error
	.on 'end', -> done()
	.bundle()

gulp.task 'mochify:cover', (done) ->
	mochify './test/index.js',
		node: true
		extension: ['.ts', '.coffee']
		transform: ['coffeeify']
	.add TYPEFILES
	.plugin tsify,
		target: 'ES5'
		noImplicitAny: true
	.plugin istanbul,
		report: ['text', 'text-summary', 'lcov']
		dir: './coverage'
	.on 'error', (error) -> done error
	.on 'end', -> done()
	.bundle()

gulp.task 'static', ->
	gulp.src ['./analytics.js', './CNAME']
	.pipe gulp.dest './dist'

gulp.task 'build', gulp.parallel 'build:html', 'build:js', 'build:css'
gulp.task 'release', gulp.series [gulp.parallel 'build:html:release', 'build:js:release', 'build:css:release'], 'static'
gulp.task 'serve', gulp.parallel 'build', 'connect', 'watch'
gulp.task 'test', gulp.parallel 'mochify:node'

gulp.task 'default', gulp.task 'test'
