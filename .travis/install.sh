#!/bin/bash

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then

  # install ubuntu gis:
  sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable --yes
  sudo apt-get --yes --force-yes update -qq

  # install specific dependencies:
  sudo apt-get install --yes udunits-bin libproj-dev libgeos-dev libgdal-dev libgdal1-dev libudunits2-dev

fi
