This is a LAMMPS fix implementing Ultra-Coarse-Graining (UCG) and Green's Function Reaction Dynamics (GFRD) for simulating
biochemical reaction network systems (ex: actin cytoskeletal networks with regulatory proteins)

Refer to the following journal articles to understand the UCG and GFRD technique:
1) The Theory of Ultra-Coarse-Graining. 1. General Principles (DOI: https://doi.org/10.1021/ct4000444) 

2) The Theory of Ultra-Coarse-Graining. 2. Numerical Implementation (DOI: https://doi.org/10.1021/ct500834t)

3) Green's Function Reaction Dynamics: A Particle-Based Approach for Simulating Biochemical Networks in Time and Space (DOI: https://doi.org/10.1063/1.2137716) 

4) Combining Molecular Dynamics with Mesoscopic Green's Function Reaction Dynamics Simulations (DOI: https://doi.org/10.1063/1.4936254)

Compilation procedure
------------------------

Step 1: download LAMMPS tarball and unzip it
Step 2: copy the *.cpp and *.h files from src directory into corresponding LAMMPS/src/ folder
Step 3: follow the usual procedure of LAMMPS compilation (https://lammps.sandia.gov/)