gulp = require 'gulp'
coffee = require 'gulp-coffee'
uglify = require 'gulp-uglify'
concat = require 'gulp-concat'
del = require 'del'
karma = require 'gulp-karma'
fs = require 'fs'
insert = require 'gulp-insert'

paths = {
  srcs: ['src/**/*.coffee'],
  tests: ['test/**/*.coffee'],
  integration: ['integration/**/*.coffee'],
  gambit: ['main/gambit.coffee'],
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

gulp.task 'integration', ['deploy'], =>
  allFileContent = fs.readFileSync 'dist/all.min.js', 'utf8'

  gulp.src(paths.integration)
    .pipe(coffee(bare: true))
    .pipe(insert.prepend(allFileContent + "\n\n"))
    .pipe(gulp.dest('dist/integration'))

gulp.task 'gambit', ['clean', 'deploy'], =>
  gulp.src(paths.srcs.concat(paths.gambit))
    .pipe(concat('gambit.min.js'))
    .pipe(coffee(bare: true))
    .pipe(uglify())
    .pipe(gulp.dest('dist'))

gulp.task 'default', =>
  gulp.src(paths.tests.concat(paths.srcs))
    .pipe(karma(
      configFile: 'karma.conf.coffee'
      action: 'watch'
    ))
