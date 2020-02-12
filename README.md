# Hamilton Guide
Hamilton is the name of the NTU High Performance Computing (HPC) cluster. It is located at IP address `152.71.6.200` and can be accessed using ssh client as follows:

```
ssh n0000000@152.71.6.200
```
where n0000000 is your username. You will be challenged for a password. This is your usual NTU login password (remember the silent response from the terminal - it's still working!).

We've had some issues where Apple Terminal users are rejected (connection reset by peer). I am investigating. At present this service is only available on campus (or via Pulse Secure VPN for staff members) owing to our network protections.

## Rules
There are strict rules to follow.
1. No use for anything other than research work.
2. Do not store any sensitive, irrelevant data.
3. Do not over-use the login node.
Note that the cluster is monitored and incorrect usage reported to a human being!

## Basic commands
To see the status of all compute nodes on the cluster:
```
sinfo -Nl
```

To see the status of the job queue:
```
squeue
squeue -u n0000000
```
The first command shows all jobs, the second just your jobs (where n0000000 is your username).

To see your quota:
```
quota -s
```
This shows you how much space you have for file storage and how many individual files you are allowed to store. If you exceed the limit, you have a grace period before nasty things start happening...

## Running scripts
Take a look at the script `test.sh` in this repository. Notice the #SBATCH header lines at the beginning. These instruct the SLURM scheduler (which I described as a "sheriff") on your anticipated resource usage. When the allotted time is up your job is forcibly terminated. If it finishes early it will end gracefully. Here is a commented version of the #SBATCH lines:
```
#SBATCH --job-name=thinking
# the job name is what appears in the NAME column when you run squeue

#SBATCH -N 1 -c 2 --mem=16G
# here we are asking for one node, 2 cores and 16Gb of RAM (i.e., not much)

#SBATCH --time=0-0:1:0
# We are asking for 1 minute here. The pattern is days-hours:minutes:seconds

#SBATCH --mail-user=EMAIL@ADDRESS
# Pop your NTU email address here and it will email you about events. It may end up in junk mail.

#SBATCH --mail-type=ALL
# ALL will tell you about all events (meaning job start, end or failure)

#SBATCH --output=/users/n0000000/thinking_%j.log
# this will cause anything that goes to standard out or standard error (i.e., what you normally see when running interactively)
# to go to a log file. The %j will be substituted with the six digit job number assigned by SLURM.
# When your job is done (or even while it is running, but be careful) you can look at this file.
```

## Git user
If you have a repository hosted somewhere on the web (e.g., on GitHub or GitLab), you can clone it into a folder on your home directory using the login node (git repos are usually small - remember not to do big stuff on the login node). Git is already installed on the cluster. To get this repo on your home directory (including the test.sh script):
```
git clone https://github.com/tethig/hamilton.git
```

If something has changed in this repo and you want to update:
```
cd hamilton
git pull
```
Note that making manual changes in git-enabled folders is not advised unless you are intending to push them up to a repo. It would break the symmetry. If that sounds like nonsense, don't worry for now, just don't write/delete any files inside the repo folder (hamilton in this case).

## Running scripts
Simple:
```
sbatch hamilton/test.sh
```
or whatever your script is called. Then use the basic commands above to see when it be queued and/or executed.

## For those of us running (Ana|Mini)conda
With miniconda installed (this is small enough to do on the login node via the command-line installer), I add this line into my scripts:
```
. /users/n0000000/miniconda3/etc/profile.d/conda.sh
```
This is required for execution because the conda environment manager is not called by default (since nodes do not source from your bash profile).

## Some guidance on HPC structure
High bandwidth 100Gbps Infiniband
Separate gigabit and management LANs
Operating system: CentOS
Compute nodes:
* 44 Intel-based compute nodes
* 32 of these have 16 cores each
* 12 nodes have 20 cores each
* Standard memory jobs (8GB/core)
* High memory compute nodes (up to 128GB/core - not sure where these ones are)
* Local scratch disks (not the same as your quota)

## External links
* [Guide to SLURM commands](https://docs.rc.fas.harvard.edu/kb/convenient-slurm-commands/)
* [SLURM cheat sheet (pdf)](https://slurm.schedmd.com/pdfs/summary.pdf)
* [Another SLURM cheat sheet](https://gist.github.com/ctokheim/bf68b2c4b78e9851b469be3425470699)
