#!/bin/bash

######
# clone canonical python gallery repositories, both branches
######

git clone https://github.com/Unidata/python-gallery python-gallery-master

git clone https://github.com/Unidata/python-gallery -b gh-pages \
    python-gallery-ghpages

######
# grab environment.yml
######

cp python-gallery-master/environment.yml .

######
# grab all notebooks from buried deep within
######

find ./python-gallery-ghpages -name \*ipynb | xargs -I {} cp {} ./notebooks

######
# Add kernel metadata for a smooth experience at jupyterhub.unidata.ucar.edu
######

find ./notebooks -name \*ipynb | xargs -I {} bash -c "jq \
 '.metadata.kernelspec.display_name = \"Python [conda env:notebook-gallery]\"' {} \
 > tmpfile; mv tmpfile {}"

find ./notebooks -name \*ipynb | xargs -I {} bash -c "jq \
 '.metadata.kernelspec.name = \"conda-env-notebook-gallery-py\"' {} \
 > tmpfile; mv tmpfile {}"

######
# Clean up
######

rm -rf python-gallery-ghpages

rm -rf  python-gallery-master
