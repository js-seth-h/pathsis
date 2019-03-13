debug = require('debug') 'pathsis'
R = require 'ramda'
path = require 'path'
fs = require 'fs'
APP_PATH = null

_getAppPaths = ()->
  from_file = process?.env?.logical_main or require?.main?.filename
  test_dir = path.dirname from_file
  while true
    test_path = path.join test_dir, '.pathsis'
    debug 'try find pathsis on', test_path

    exists = fs.existsSync test_path
    break if exists
    next_dir = path.dirname test_dir
    if test_dir is next_dir
      throw new Error 'No Pathsis File'
    test_dir = next_dir

  file = test_path
  text = fs.readFileSync file, 'utf8'
  app_path = JSON.parse text
  toAbs = (p)-> path.resolve test_dir, p
  app_path = R.map toAbs, app_path
  # app_path.ROOT = test_dir
  return APP_PATH = app_path

module.exports = _getAppPaths()
