# `rJava` questions

How to install `rJava` under different operating systems

 * Installation
 * Troubleshooting

## Installation

### Ubuntu 14.5 (Trusty Tahr)

The `.travis.yml` file shows a Trusty install:

```
 - sudo apt-get install -qq oracle-java8-installer # Java 8
 - sudo apt-get install oracle-java8-set-default
```

So I assume the same can be achieved with:

```
sudo add-apt-repository -y ppa:webupd8team/java 
sudo apt-get update -qq
sudo apt-get install oracle-java8-installer
sudo apt-get install oracle-java8-set-default
```

### Ubuntu 17.10 (Artful Aardvark)

```
sudo apt-get install r-cran-rjava openjdk-8-jdk
R CMD javareconf
```

Do not use `openjdk-9-jdk`.

### Ubuntu 18.4 (Bionic Beaver)

The `.travis.yml` file shows a Trusty install:

```
 - sudo apt-get install -qq oracle-java8-installer # Java 8
 - sudo apt-get install oracle-java8-set-default
```

On Bionic, I assume the same can be achieved with:

```
sudo add-apt-repository -y ppa:webupd8team/java 
sudo apt-get update -qq
sudo apt-get install oracle-java8-installer
sudo apt-get install oracle-java8-set-default
```


## Troubleshooting

### Error: `libjvm.so: cannot open shared object file: No such file or directory`

#### Random solution 1

Sometimes works:

For me, [this Stack Overflow post](https://stackoverflow.com/a/25932828) helped me out:

```
sudo mousepad /etc/ld.so.conf.d/java.conf
```

In that file put:

```
/usr/lib/jvm/java-8-oracle/jre/lib/amd64
/usr/lib/jvm/java-8-oracle/jre/lib/amd64/server
```

Save, close, restart R studio, fixed!

#### Random solution 2

Random notes:

Else [this Stack Overflow post may be helpful](https://stackoverflow.com/a/43466434):

Ruthlessly install all JDK stuff:

```
sudo apt-get install jdk-*
```

```
sudo R CMD javareconf
```

```
sudo R CMD javareconf -e
export LD_LIBRARY_PATH=$JAVA_LD_LIBRARY_PATH
sudo apt-get install r-cran-rjava
```

### BEAST2 cannot find Java

![BEAST2 cannot find Java](beast_cannot_find_java.png)

Download the Oracle Java SDK:

![](download_oracle_java_sdk.png)

Open the Oracle Java SDK with the package installer:

![](open_oracle_java_sdk.png)

Install the Oracle Java SDK with the package installer:

![](install_oracle_java_sdk.png)

Reconfig:

```
sudo R CMD javareconf
```
