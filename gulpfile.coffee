gulp = require 'gulp'
coffeelint = require 'gulp-coffeelint'

gulp.task 'lint', ->
  gulp.src ['./scripts/*.coffee', './runnner.coffee', './gulpfile.coffee']
    .pipe coffeelint()
    .pipe coffeelint.reporter()
    .pipe coffeelint.reporter 'fail'

gulp.task 'test', ['lint']
