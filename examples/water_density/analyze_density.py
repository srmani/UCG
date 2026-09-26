#!/usr/bin/env python3
"""Extract thermo data from a LAMMPS log and plot density vs time.

Usage: python3 analyze_density.py [log.lammps]
Writes thermo.csv and density_vs_time.png next to the log.
"""
import os
import sys

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np


def read_thermo(path):
    """Return (header, rows) for the last thermo block in a LAMMPS log."""
    header, rows, block = None, [], False
    with open(path) as f:
        for line in f:
            fields = line.split()
            if fields[:2] == ["Step", "Time"]:
                header, rows, block = fields, [], True
            elif block:
                if line.startswith("Loop time"):
                    block = False
                    continue
                try:
                    rows.append([float(x) for x in fields])
                except ValueError:
                    pass  # warnings interleaved with thermo output
    if header is None:
        sys.exit(f"No thermo block found in {path}")
    return header, np.array(rows)


def main():
    log = sys.argv[1] if len(sys.argv) > 1 else "log.lammps"
    outdir = os.path.dirname(os.path.abspath(log))
    header, data = read_thermo(log)
    col = {name: i for i, name in enumerate(header)}

    np.savetxt(os.path.join(outdir, "thermo.csv"), data, delimiter=",",
               header=",".join(header), comments="", fmt="%.6g")

    t_ns = data[:, col["Time"]] / 1.0e6  # real units: time in fs
    rho = data[:, col["Density"]]

    # Equilibrium statistics over the second half of the run
    half = t_ns >= t_ns[-1] / 2
    mean, std = rho[half].mean(), rho[half].std()

    fig, axes = plt.subplots(4, 1, figsize=(8, 10), sharex=True)
    for ax, name, label in zip(
        axes,
        ["Density", "TotEng", "Temp", "Press"],
        ["Density (g/cm$^3$)", "Total energy (kcal/mol)", "Temperature (K)",
         "Pressure (atm)"],
    ):
        ax.plot(t_ns, data[:, col[name]], lw=1)
        ax.set_ylabel(label)
        ax.grid(alpha=0.3)
    axes[0].axhline(mean, color="k", ls="--", lw=1,
                    label=f"mean (t > {t_ns[-1] / 2:.1f} ns) = {mean:.4f} ± {std:.4f}")
    axes[0].legend(loc="lower right")
    axes[-1].set_xlabel("Time (ns)")
    fig.suptitle("SPC/E water, 1000 molecules, NPT 298 K / 1 atm")
    fig.tight_layout()
    fig.savefig(os.path.join(outdir, "density_vs_time.png"), dpi=150)

    print(f"{len(data)} thermo rows, t = 0 .. {t_ns[-1]:.3f} ns")
    for name in ["Density", "TotEng", "Temp", "Press"]:
        v = data[half, col[name]]
        print(f"{name:8s} mean {v.mean():12.4f}  std {v.std():10.4f}  (second half)")


if __name__ == "__main__":
    main()
