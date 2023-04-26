#!/bin/bash

# DISCLAIMER   :   It is recomended to test this script on a test machine.
#                  ManageEngine will not be responsible for any damage/loss
#                  to the data/setup based on the behavior of the script.
#
# DESCRIPTION  :   Script to list the existing Cronjob in linux agent machines.
#
# ARGUMENT(S):
#      No arguments needed for this script. Just select this script from repository
#
#           RETURN VALUE          MEANING
#
#                0             Cronjob listed successfully
#                1             Error while listing Cronjob
#                2             Invalid arguments.
#
# NOTE :
#   To see the script output, Kindly enable the option Enable logging in Troubleshooting while deploying configuration.

errorCode=2

euid=$(id -u)
for i in 1; do

  #check root access
  if [ $euid -ne 0 ]; then
    echo "This script must be run as root"
    break
  fi

  #Check the number of arguments
  if [ $# -ne 0 ]; then
    echo "Incorrect Usage : Arguments mismatch."
    echo "Refer ARGUMENT(S) section in this script."
    break
  fi

  errorCode=0

  #List the jobs
  crontab -l

  if [ $? -ne 0 ]; then
    echo "Error while listing Cronjob"
    errorCode=1
  fi

done

errorFunc() {
  return $errorCode
}

errorFunc
