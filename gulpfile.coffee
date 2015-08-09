gulp = require 'gulp'
eol = require 'gulp-eol'
rename = require 'gulp-rename'
minifyCSS = require 'gulp-minify-css'
minifyHTML = require 'gulp-minify-html'
uglify = require 'gulp-uglify'
compass = require 'gulp-compass'
base64 = require 'gulp-base64'
livereload = require 'gulp-livereload'


devPath = 'src/develop'
devViewsPath = "#{devPath}/views"
devResourcePath = "#{devPath}/public"
devSassPath = "#{devResourcePath}/sass"
devCSSPath = "#{devResourcePath}/css"
devJSPath = "#{devResourcePath}/js"
devLibPath = "#{devResourcePath}/lib"
devImgPath = "#{devResourcePath}/img"

bldPath = 'src/build'
bldViewsPath = "#{bldPath}/views"
bldResourcePath = "#{bldPath}/public"
bldCSSPath = "#{bldResourcePath}/css"
bldJSPath = "#{bldResourcePath}/js"
bldLibPath = "#{bldResourcePath}/lib"
bldImgPath = "#{bldResourcePath}/img"

eolFile = (filePath, destPath) ->
  console.log "eolFile filePath: #{filePath}"
  gulp.src filePath
    .pipe eol '\n'
    .pipe gulp.dest destPath


# compass task
gulp.task 'compass', () ->
  gulp.src "#{devSassPath}\/*.scss"
    .pipe compass
      css: devCSSPath
      sass: devSassPath
    .on 'error', (error) ->
      console.log error
      @emit 'end'
# watch-compass task
gulp.task 'watch-compass', () ->
  gulp.watch "#{devSassPath}\/*.scss", ['compass']
  gulp.watch "#{devCSSPath}\/*.css", (obj) ->
    eolFile obj.path, devCSSPath

# eol-css task
gulp.task 'eol-css', ['compass'], () ->
  eolFile "#{devCSSPath}\/*.css", devCSSPath

# watch task
gulp.task 'watch', ['watch-compass'], () ->
  do livereload.listen
  gulp.watch [
    "#{devViewsPath}\/**\/*.*"
    "#{devJSPath}\/**\/*.*"
    "#{devCSSPath}\/**\/*.*"
    "#{devImgPath}\/**\/*.*"
  ], (file) ->
    livereload.changed file.path

# build task
gulp.task 'build', () ->
  gulp.src "#{devCSSPath}\/*.css"
    .pipe base64
      extensions: [/#tobase64"?$/i]
    .pipe do minifyCSS
    .pipe gulp.dest bldCSSPath

  gulp.src "#{devJSPath}\/**\/*.js"
    .pipe do uglify
    .pipe gulp.dest bldJSPath

  gulp.src "#{devImgPath}\/**\/*.*"
    .pipe gulp.dest bldImgPath

  gulp.src "#{devViewsPath}\/**\/*.ejs"
    .pipe gulp.dest bldViewsPath

  gulp.src ["#{devLibPath}\/**\/*", "#{devLibPath}\/**\/.*"]
    .pipe gulp.dest bldLibPath