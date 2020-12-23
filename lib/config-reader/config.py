#!/usr/bin/python3

import sys, getopt, configparser, os

def main(argv):
   projectName = ''
   setting = ''
   try:
      opts, args = getopt.getopt(argv,"hp:s:",["project-name=","setting="])
   except getopt.GetoptError:
      print('config.py -p <project-name> -s <setting>')
      sys.exit(2)

   for opt, arg in opts:
      if opt == '-h':
         print('config.py -p <project-name> -s <setting>')
         sys.exit()
      elif opt in ("-p", "--project-name"):
         projectName = arg
      elif opt in ("-s", "--setting"):
         setting = arg

   try:
       config = configparser.ConfigParser()
       config.sections()
       config.read(os.path.abspath(sys.argv[0] + '../../../../config.ini'))
       settingValue = config[projectName][setting]
       print(settingValue)
   except:
       print(
            "ERROR: It seems like you've forgotten to specify setting: {"
             + setting +
             "} for your project: {" + projectName +
             "} in the {config.ini} file."
       )
       sys.exit(2)

if __name__ == "__main__":
   main(sys.argv[1:])
