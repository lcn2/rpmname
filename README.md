# rpmname

list installed package names without version strings


# To install

```sh
sudo make install
```


# Examples

List all package names other than kernel packages and GPG keys

```sh
$ /usr/local/bin/rpmname
```

List all package names, including kernel packages and GPG keys

```sh
$ /usr/local/bin/rpmname -k
```


# To use

```
/usr/local/bin/rpmname [-h] [-v level] [-V] [-N] [-k] [-s] [-d] [-t {dkpg|rpm} [-T path]]

    -h          print help message and exit
    -v level    set verbosity level (def level: 0)
    -V          print version string and exit

    -N          do not process anything, just parse arguments (def: process something)

    -k          include non-debian kernel and GPG public keys (def: don't)
    -s          do not sort (def: sort)
    -d          do not exclude duplicates (def: include duplicates)

    -t {dkpg|rpm}   force use of either Debian dkpg or RedHat rpm (def: try dkpg then try rpm)
    -T path	path to the selected type of tool (requires use of -t type)

Exit codes:
     0         all OK
     1         some internal tool exited non-zero
     2         -h and help string printed or -V and version string printed
     3         command line error
 >= 10         internal error

rpmname version: 1.5.1 2025-03-26
```


# Reporting Security Issues

To report a security issue, please visit "[Reporting Security Issues](https://github.com/lcn2/rpmname/security/policy)".
