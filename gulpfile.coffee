gulp = require 'gulp'
coffeelint = require 'gulp-coffeelint'

gulp.task 'lint', ->
  gulp.src './scripts/*.coffee'
    .pipe coffeelint()
    .pipe coffeelint.reporter()

gulp.task 'test', ['lint']
