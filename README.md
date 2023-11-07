# JuliaHEP 2023 - HPC Tutorial

A short tutorial on node-level HPC with Julia. It will take place as part of the [JuliaHEP 2023 Workshop](https://indico.cern.ch/event/1292759/) at the Erlangen Center for Astroparticle Physics (ECAP) in November 2023.

### [PC2 JupyterHub](https://jh.pc2.uni-paderborn.de/)

**Link:** https://pc2.de/go/jupyterhub

Most participants will get access to the [Noctua 2](https://pc2.uni-paderborn.de/hpc-services/available-systems/noctua2) cluster through the [PC2 JupyterHub](https://jh.pc2.uni-paderborn.de/hub/home).

In this case, **a browser is all that's needed!**

#### Getting started

* Login to [PC2 JupyterHub](https://pc2.de/go/jupyterhub) with the provided credentials.
* After login, click on the "Start My Server" button.
* Select the **"JuliaHEP - HPC Tutorial (full CPU node)"** preset (should already be the default) and click on "Start". This will start a Jupyter server on a Noctua 2 compute node (might take a little while).
* Once in Jupyter, you should see a folder with your username in the left side bar. Navigate into this folder. In it you'll find a local copy of this git repository that you can use for the tutorial.
* To make Julia (and the IJulia kernel) available, click on the little blue hexagon in the side bar on the left. Then, type "jupyter" into the search bar at the top. Hover over `JupyterKernel-Julia/1.9.3-foss-2022a-CUDA-11.7.0` and click on the appearing "Load" button.
* You should be all set up! Feel free to open the first notebook `1_axpy_cpu.ipynb` and, in the top right corner, select the kernel **"Julia (8 threads) 1.9.3"**.

### HTML version

In the [`gh-pages`](https://github.com/carstenbauer/juliahep-hpctutorial/tree/gh-pages/) branch, we provide a **non-interactive** version of the tutorial materials.

* [axpy_cpu](https://carstenbauer.github.io/juliahep-hpctutorial/1_axpy_cpu.html)
* [axpy_cpu_scaling](https://carstenbauer.github.io/juliahep-hpctutorial/2_axpy_cpu_scaling.html)
* [axpy_xpu](https://carstenbauer.github.io/juliahep-hpctutorial/3_axpy_xpu.html)
* [heat_equation](https://carstenbauer.github.io/juliahep-hpctutorial/4_heat_equation.html)

**Note:** You may want to use the html pages to follow along if you don't have cluster-access.

### Preparation (own device/cluster)
<details>
  <summary>Click me</summary>
  
Most participants will run the tutorial on the Noctua 2 cluster and **don't need to prepare anything**. However, if you want to/need to, this is what you should do.

* Install Julia (preferrably with [juliaup](https://github.com/JuliaLang/juliaup))
* Install [VS Code](https://code.visualstudio.com/) and the [Julia extension](https://marketplace.visualstudio.com/items?itemName=julialang.language-julia)
* Run the following script:

  ```bash
  git clone https://github.com/carstenbauer/juliahep-hpctutorial
  cd juliahep-hpctutorial
  julia setup.jl
  ```

**Note:** To be as self-contained as possible, the Julia environment for the tutorial is configured to use Julia's CUDA artifact(s) and not a potentially available local CUDA toolkit. For this reason, a few GB will be downloaded as part of the setup.

If you want to work **on a cluster** that you have access to, you also need to make sure to

* have the [Remote SSH Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) installed
* have the Julia extension installed and working **on the cluster**

In particular the latter (most likely) requires you to set the `julia.exectuablePath` setting to point to a valid julia executable. If your cluster uses Lmod modules (which it almost certainly does), you might need to create a julia wrapper script similar to what is described [here](https://upb-pc2.atlassian.net/wiki/spaces/PC2DOK/pages/1903803/VS+Code+Remote+Usage#Julia-wrapper%3A-manual-approach-(not-recommended!)).
</details>

### Noctua 2 VS Code Access (for the bold/curious)
<details>
  <summary>Click me</summary>
  
If you want to dare to access a Noctua 2 **compute node** (not just a login node!) with VS Code instead of via JupyterHub, this is what you should do:

* Put the following into your `.ssh/config` (if it doesn't exist, create it) and replace `<username>` with the username that you've received.
  
  ```
  # PC2 training jumphost (accessible from everywhere)
  Host pc2-training-jumphost
      HostName training.pc2.upb.de
      User <username>
  
  # Accessing Noctua2 via jumphost
  Host noctua2
      Hostname n2login2.ab2021.pc2.uni-paderborn.de
      User <username>
      ProxyJump pc2-training-jumphost
  
  # Accessing compute nodes with VS Code directly
  Host n2gpu* n2cn*
      HostName %h
      ProxyJump noctua2
      User <username>
  ```

* Open a regular terminal and `ssh noctua2`.
* Once there, request an interactive session on a compute node: `srun -A hpc-lco-usrtr -N 1 --exclusive -p normal -t 1:00:00 --pty bash`
* Once you have it, copy the name of the compute node (e.g. `n2cn0164`).
* Open VS Code and use the `Remote SSH: Connect to Host` feature to connect to the compute node (paste the node name in the popup window and confirm with enter)
* Once you are on the compute node, make sure to install the Julia Extension (via the left side bar).
* Once you have the Extension, set the `julia.executablePath` setting to point to: `/opt/software/pc2/julia/julia_vscode`.
* That's it! You should be good to go!
</details>

## Acknowledgements

The HPC resources for this tutorial are provided by the Paderborn Center for Parallel Computing (PC2) within the German National High-Performance Computing Alliance (NHR).

<div style="float: left">
 <a href="https://pc2.uni-paderborn.de/"><img src="https://user-images.githubusercontent.com/187980/190167755-ead6173d-fb87-40da-ae0f-f0c99e72c22b.png" height=100px></a>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
 <a href="https://www.nhr-verein.de/"><img src="https://user-images.githubusercontent.com/187980/190169322-89560987-69cf-4c6f-9236-993704461763.svg" height=100px></a>
</div>
