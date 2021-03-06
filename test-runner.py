from subprocess import call
import os, time, sys

def last_update(source_paths):
  #takes array of paths and returns the last updated file 
  last_change = 0
  for path in source_paths:
    if (os.path.isfile(path)):
      change = os.stat(path).st_mtime
    elif (os.path.isdir(path)):
      # folder, recursively call last_update
      change = last_update([path])
    else:
      raise ValueError(path + " is not a file/folder")
    if change > last_change:
      last_change = change
  return last_change

try:
  test_file = sys.argv[1]
  wait_time = int(sys.argv[2])
  source = sys.argv[3:]
except IndexError, ValueError:
  sys.exit("Usage: python test-runner.py test_file wait_time source (+source)\n"\
    "test_file = File containing tests\n"\
    "wait_time = Wait time between file change check)\nsource = File or folder containing code you wish to check for changes\n"\
    "Example: python test-runner.py 'tests.scm' 5 'src/' 'othersrc/otherfile.scm'")

last_change = last_update(source)

print "Polling for file changes every " + str(wait_time) + " seconds in " + str(source)
while (True):
  check_change = last_update(source)
  if (check_change > last_change):
    print "Source changed, executing tests from " + test_file
    cmd = "gsi " + test_file
    print cmd
    call(cmd, shell=True)
    last_change = check_change

  time.sleep(wait_time)