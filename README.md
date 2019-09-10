# RHPAM-7.4 Sandbox Installation

## Installation packages

- Download and copy [installation packages](installs/README.md) to ./installs folder

## Run RHPAM installation script

```
$ ./1-install.sh
```

## Configure RHPAM

- Start EAP Server in admin mode

```
$ cd ../rhpam-7.4/bin
$ ./standalone.sh -c standalone-full.xml --admin-only
```

- In another terminal, run the system properties configuration script

```
$ ./2-add-props.sh
```

- Then, run the kie server configuration script

```
$ ./3-add-kieserver-props.sh
```

- Optionally, you can configure the persistance with the provided scripts.

- Stop EAP Server (admin mode)

## Start RHPAM

```
$ cd ../rhpam-7.3
$ ./bin/standalone.sh -c standalone-full.xml
```
