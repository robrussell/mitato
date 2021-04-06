# Quick start

1. [Install WSL2](https://docs.microsoft.com/en-us/windows/wsl/install-win10). Ignore the part about installing a distro from the store, just [download their Ubuntu 20.04 distro directly](https://docs.microsoft.com/en-us/windows/wsl/install-manual).

2. [Install Docker desktop](https://docs.docker.com/docker-for-windows/install/). You don't need to sign in to Docker to use it.

3. [Install Windows Terminal](https://github.com/microsoft/terminal/releases) and/or [VSCode](https://code.visualstudio.com/) for [a terminal](console.md).

4. Open up a terminal. Use the Ubuntu 20.04 option installed above. Set that as the default in Windows Terminal settings. This is a working Bash shell. It can be used to install, build, or run Linux applications directly. The filesystem is the same filesystem seen by Windows on the same machine.

5. Run a Docker container and connect to it. Here are some examples:
    * jupyter/tensorflow-notebook
    * alpine
    * perl

## jupyter/tensorflow-notebook
There are a bunch of Jupyter notebook images maintained on the [Jupyter Stacks site](https://jupyter-docker-stacks.readthedocs.io/en/latest/index.html). This one has TensorFlow2, Keras, pandas, scipy, scikit-learn, bokeh, hdf5, and Facets. Outside Jupyter it also has TeX Live, git, and vim. The default user is name `jovyan`. Run the commands below then follow the link that shows up in the terminal output.

```bash
cd
mkdir tf-work
cd !$
docker run -it --rm -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v "$PWD":/home/jovyan/work jupyter/tensorflow-notebook:latest
```

## alpine

Alpine isn't that interesting on its own but it shows that a Docker image doesn't need to be gigabytes in size. Alpine is a minimal Linux distro built on top of BusyBox. The image is only 5MB so works well as the base for distributing other software inside a container.

```bash
docker run -it --rm alpine:latest
```

## perl

Run a Perl one-liner with this container:

```bash
docker run -it --rm perl:5.20 perl -E 'print("Hello, World!\n");'
```

Or adapt this command if you have a Perl script:

```bash
docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp perl:5.20 perl your-daemon-or-script.pl
```

## ocaml

```bash
docker run --rm -p 80:8080 -v learn-ocaml-sync:/sync --name learn-ocaml-server learn-ocaml-app
```

More usage details at https://hub.docker.com/_/perl.

# Next step

[Make your own container image](custom.md) suited to your needs.