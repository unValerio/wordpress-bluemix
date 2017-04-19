#!/bin/bash
set -e

# This is the mount point for the shared volume.
# Use this mount point with the bx ic run command.
# By default the mount point is owned by the root user.
MOUNTPATH="/var/www"
MY_USER=${MY_USER:-"myguest"}

# This function creates a subdirectory that is owned by 
# the non-root user under the shared volume mount path.
create_data_dir() {
  #Add the non-root user to primary group of root user.
  usermod -aG root $MY_USER

  # Provide read-write-execute permission to the group for the shared volume mount path.
  chmod 775 $MOUNTPATH

  # Create a directory under the shared path owned by non-root user myguest.
  su -c "mkdir -p ${MOUNTPATH}/html" -l $MY_USER
  su -c "chmod 700 ${MOUNTPATH}/html" -l $MY_USER
  ls -al ${MOUNTPATH}

  # For security, remove the non-root user from root user group.
  deluser $MY_USER root

  # Change the shared volume mount path back to its original read-write-execute permission.
  chmod 755 $MOUNTPATH
  echo "Created Data directory..."
}

create_data_dir

# This command creates a long-running process for the purpose of this example.
# tail -F /dev/null