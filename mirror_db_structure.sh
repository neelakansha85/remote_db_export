#!/bin/bash

mirrorDbStructure() {
  # Config Options
  # do the following variables also have to be readonly
  arg1=$1
  exportDir=${2:-'db_export'}
  importScript='import.sh'
  dropSqlFile='drop_tables'
  superAdminTxt='superadmin_dev.txt'
  propertiesFile='db.properties'

  if [ "$arg1" == "mk" ]; then
	  if [ ! -d "$exportDir" ]; then
	    mkdir $exportDir
	  else
		  # Remove all .sql files from previous run if any
		  echo "Emptying ${exportDir} dir..."
		  rm -rf $exportDir
		  mkdir $exportDir
	  fi

	  # Remove all bash scripts from previous run if any
	  echo "Attempting to remove all old script files if exists on server"
	  rm -f $importScript $propertiesFile $dropSqlFile.sql $superAdminTxt

  elif [ "$arg1" == "rm" ]; then
	  rm -f $importScript $propertiesFile $dropSqlFile.sql $superAdminTxt
  fi
}

mirrorDbStructure $@
