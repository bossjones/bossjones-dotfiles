#! /usr/bin/python
# source: https://grox.net/software/mine/slowcat/
# slowcat.py - print a file slowly
# author : dave w capella - http://grox.net/mailme
# date     : Sun Feb 10 21:57:42 PST 2008
############################################################
import sys, time

delay = .02

if len(sys.argv) > 1:
  arg = sys.argv[1]
  if arg != "-d":
    print "usage: %s [-d delay]" % (sys.argv[0])
    print "delay: delay in seconds"
    print "example: %s -d .02 < vtfile" % (sys.argv[0])
    sys.exit()
  if len(sys.argv) > 2:
    delay = float(sys.argv[2])

while 1:
  try:
    print raw_input()
  except:
    break
  time.sleep(delay)

######################################################################
# eof: slowcat.py
