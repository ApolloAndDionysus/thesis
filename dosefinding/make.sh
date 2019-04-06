#!/bin/bash

latex ClinicalTrials.tex
dvips -t letter ClinicalTrials.dvi
ps2pdf ClinicalTrials.ps

