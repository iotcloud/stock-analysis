Prerequisites
-----
1. Operating System
  * This program is extensively tested and known to work on,
    *  Red Hat Enterprise Linux Server release 5.10 (Tikanga)
    *  Ubuntu 12.04.3 LTS
    *  Ubuntu 12.10
  * This may work in Windows systems depending on the ability to setup OpenMPI properly, however, this has not been tested and we recommend choosing a Linux based operating system instead.

2. Java
  * Download Oracle JDK 8 from http://www.oracle.com/technetwork/java/javase/downloads/index.html
  * Extract the archive to a folder named `jdk1.8.0`
  * Set the following environment variables.
  ```
    JAVA_HOME=<path-to-jdk1.8.0-directory>
    PATH=$JAVA_HOME/bin:$PATH
    export JAVA_HOME PATH
  ```
3. Apache Maven
  * Download latest Maven release from http://maven.apache.org/download.cgi
  * Extract it to some folder and set the following environment variables.
  ```
    MVN_HOME=<path-to-Maven-folder>
    $PATH=$MVN_HOME/bin:$PATH
    export MVN_HOME PATH
  ```
4. OpenMPI
  * We recommend using `OpenMPI 1.8.1` although it works with the previous 1.7 versions. The Java binding is not available in versions prior to 1.7, hence are not recommended. Note, if using a version other than 1.8.1 please remember to set Maven dependency appropriately in the `pom.xml`.
  * Download OpenMPI 1.8.1 from http://www.open-mpi.org/software/ompi/v1.8/downloads/openmpi-1.8.1.tar.gz
  * Extract the archive to a folder named `openmpi-1.8.1`
  * Also create a directory named `build` in some location. We will use this to install OpenMPI
  * Set the following environment variables
  ```
    BUILD=<path-to-build-directory>
    OMPI_181=<path-to-openmpi-1.8.1-directory>
    PATH=$BUILD/bin:$PATH
    LD_LIBRARY_PATH=$BUILD/lib:$LD_LIBRARY_PATH
    export BUILD OMPI_181 PATH LD_LIBRARY_PATH
  ```
  * The instructions to build OpenMPI depend on the platform. Therefore, we highly recommend looking into the `$OMPI_181/INSTALL` file. Platform specific build files are available in `$OMPI_181/contrib/platform` directory.
  * In general, please specify `--prefix=$BUILD` and `--enable-mpi-java` as arguments to `configure` script. If Infiniband is available (highly recommended) specify `--with-verbs=<path-to-verbs-installation>`. In summary, the following commands will build OpenMPI for a Linux system.
  ```
    cd $OMPI_181
    ./configure --prefix=$BUILD --enable-mpi-java
    make;make install
  ```
  * If everything goes well `mpirun --version` will show `mpirun (Open MPI) 1.8.1`. Execute the following command to instal `$OMPI_181/ompi/mpi/java/java/mpi.jar` as a Maven artifact.
  ```
    mvn install:install-file -DcreateChecksum=true -Dpackaging=jar -Dfile=$OMPI_181/ompi/mpi/java/java/mpi.jar -DgroupId=ompi -DartifactId=ompijavabinding -Dversion=1.8.1;
  ```
  * Few examples are available in `$OMPI_181/examples`. Please use `mpijavac` with other parameters similar to `javac` command to compile OpenMPI Java programs. Once compiled `mpirun [options] java -cp <classpath> class-name arguments` command with proper values set as arguments will run the program.

Building the program
-----
* Check all prerequisites are satisfied before building davs
* Clone this git repository from `https://github.com/iotcloud/stock-analysis.git` Let's call this directory `stockshome`
* Once above two steps are completed, building project requires only one command, `mvn install`, issued within `stockshome/mpi`.
* This will build a jar file named stocks-1.0-ompi1.8.1-jar-with-dependencies.jar inside stockshome/mpi/target

Running the program
-----
Go to the stockshome/mpi directory and run the command
```
mpirun --report-bindings --hostfile nodes -np 4 java -cp target/stocks-1.0-ompi1.8.1-jar-with-dependencies.jar Program -v sample.txt -d distance.txt
```