#!/bin/bash
#
# Installs BEAST2 using the R code in the 'beastierinstall' and 'beastier' package
#
# Because the R code in the packages use namespaces 
# 'beastier::' and 'beastierinstall::' in calling
# its functions, this scipt removes these namespaces
#
# Usage:
#
#  ./scripts/install_beast2.sh
#
#
mkdir temp
mkdir temp/beastier
mkdir temp/beastierinstall
git clone --depth 1 https://github.com/ropensci/beastier temp/beastier
git clone --depth 1 https://github.com/richelbilderbeek/beastierinstall temp/beastierinstall
cat temp/beastier/R/*.R > install_beast2.R
cat temp/beastierinstall/R/*.R >> install_beast2.R
echo "install_beast2()" >> install_beast2.R
sed -i'.orginal' "s/beastier:://g" install_beast2.R
sed -i'.orginal' "s/beastierinstall:://g" install_beast2.R
cat install_beast2.R
Rscript install_beast2.R
rm -rf temp
