J = require 'jsl'
debug = J.debug __filename, on
R = require 'ramda'
path = require 'path'
fs = require 'fs'
APP_PATH = null

_getAppPaths = ()->
  test_dir = path.dirname require.main.filename
  while not fs.existsSync path.join test_dir, '.pathsis'
    next_dir = path.dirname test_dir
    if test_dir is next_dir
      throw new Error 'No Pathsis File'
    test_dir = next_dir

  file = path.join test_dir, '.pathsis'
  text = fs.readFileSync file, 'utf8'
  app_path = JSON.parse text
  toAbs = (p)-> path.resolve test_dir, p
  app_path = R.map toAbs, app_path
  # app_path.ROOT = test_dir
  return APP_PATH = app_path

module.exports = _getAppPaths()
