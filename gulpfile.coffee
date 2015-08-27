gulp = require 'gulp'
coffee = require 'gulp-coffee'
uglify = require 'gulp-uglify'
concat = require 'gulp-concat'
del = require 'del'
karma = require 'gulp-karma'

paths = {
  srcs: ['src/**/*.coffee'],
  tests: ['test/**/*.coffee'],
}

gulp.task 'clean', (cb) =>
  del ['dist'], cb

gulp.task 'deploy', ['clean'], =>
  gulp.src(paths.srcs)
    .pipe(concat('all.min.js'))
    .pipe(coffee(bare: true))
    .pipe(uglify())
    .pipe(gulp.dest('dist'))

gulp.task 'test', =>
  gulp.src(paths.tests.concat(paths.srcs))
    .pipe(karma(
      configFile: 'karma.conf.coffee'
      action: 'run'
    ))

gulp.task 'default', =>
  gulp.src(paths.tests.concat(paths.srcs))
    .pipe(karma(
      configFile: 'karma.conf.coffee'
      action: 'watch'
    ))
