# SSL DiSEL 1.0
 
README FILE FOR SEL/DiSEL SOFTWARE AS PART OF THE MANUSCRIPT -
Bhimsaria D, et al. (2018) Specificity landscapes unmask submaximal binding site preferences of transcription factors. Proc Natl Acad Sci 115(45):E10586–E10595.

Please cite the above manuscript if you use the code.

AUTHOR- DEVESH BHIMSARIA

Tool to generate 3 dimensional landscape plots for high throughput protein-DNA binding data

"commands_1.m" file contains the command line format commands used to obtain some of the figures in the manuscript.

INSTRUCTIONS:
NOTE- Move mouse pointer over any blue text on GUI to display tooltip/help.
1) Run ssl_gui_1.m in MATLAB.
2) Select radio button "SEL" or "DiSEL" to create an SEL or DiSEL, respectively.
3) Enter or select "Input File 1" containing DNA-Protein binding data as k-mer sequence, reverse complement and binding intensity (e.g., CSI or PBM 8mer or 10mer data, see DATA folder for an example). It should contain all non-repeated k-mers e.g. for 8mer-32896 data points.
4) If you wish to prepare a DiSEL, use "Input File 2" to enter a second input file with DNA-Protein binding data. This will generate a DiSEL of "Input File 1" over "Input File 2". The file format and order of sequences has to be the same as in "Input File 1".
5) Enter the "Seed motif" e.g. AAGTG, WGATAA. Motif should only contain- ACGTWSYRKMBDHVN alphabets (IUPAC notation). Select a motif for which there are at least 4 sequences matching that motif in the input file(s).
6) Note: You can click "Load previous inputs" to load all the inputs from last time the program ran.

Steps 7 to 13 are optional inputs-
7) Enter "Output file name" to generate text output from SEL/DiSEL program with X,Y,Z coordinates corresponding to plotted sequence, its intensity and mismatch. If left blank, the program will NOT generate any text output file.
8) "Circular/Linear" can be used to choose
	a) Circular SEL (Default) - to plot each mismatch content as concentric rings
	b) Linear SEL or Bar Plot SEL- to plot each mismatch content as a series of bar graphs
9) Use "Arrangement" to select different ordering of sequences. Sequences in each ring of SEL/DiSEL are arranged according to a preference order, which can be selected from the drop-down button. Different preference orders are explained below.
	a) 1- 1st- flanking on 3′ end of motif. 2nd- flanking on 5′ end of motif. 3rd- mismatched base. 4th- position of motif in sequence.(default)
	b) 2- 1st- flanking on 5′ end of motif. 2nd- flanking on 3′ end of motif. 3rd- mismatched base. 4th- position of motif in sequence.
	c) 3- 1st- mismatched base. 2nd- flanking on 3′ end of motif. 3rd- flanking on 5′ end of motif. 4th- position of motif in sequence.
	d) 4- 1st- mismatched base. 2nd- flanking on 5′ end of motif. 3rd- flanking on 3′ end of motif. 4th- position of motif in sequence.
	e) 5- 1st- position of motif in sequence. 2nd- flanking on 3′ end of motif. 3rd- flanking on 5′ end of motif. 4th- mismatched base. 
	f) 6- 1st- position of motif in sequence. 2nd- flanking on 5′ end of motif. 3rd- flanking on 3′ end of motif. 4th- mismatched base. 
	g) 7- 1st- position of motif in sequence. 2nd- mismatched base. 3rd- flanking on 3′ end of motif. 4th- flanking on 5′ end of motif.
	h) 8- 1st- position of motif in sequence. 2nd- mismatched base. 3rd- flanking on 5′ end of motif. 4th- flanking on 3′ end of motif.
	i) 9 to 16- same as 1 to 8 respectively except that 9-16 has a higher preference for ordering for motif itself, whereas 1 to 8 had lowest. Specially important when using multiple different motifs for a single DPI.
10) Change "Intensity/count column" to plot data from a column other than column 3 in input files.
11) "Lowest mismatch ring" to be plotted can be selected here. Default is Mismatch 0 (perfect match).
12) "Highest mismatch ring" to be plotted can be selected here. Default is Maximum mismatch to the seed motif. Note, the more mismatch rings that are displayed, the longer the time required to generate the plot. Furthermore, there has to be at least 10 sequences to plot in any ring mismatch>=1, otherwise that ring will be skipped.
13) For noisy data, a moving window can be used to smoothen the data in each ring. "Smoothening" means ring with N sequences is smoothened with a moving window of N*s/100 width using smooth function of MATLAB. We suggest to use smoothening <=0.5.
14) "Mismatch Peak" is used by automated algorithm to pick mismatch peak defined as - a cutoff percentage defining difference between median of all the sequences having a particular mismatch (mismatch peak) and median of all the sequences having same number of mismatch (mismatch ring). Percentage is calculated by dividing over the maximum intensity.
15) "Flanking Peak" is used by automated algorithm to pick flanking peak defined as - a cutoff percentage defining difference between intensity of a particular sequence and median of all the sequences having same mismatches (mismatch peak), i.e. considering a sequence as peak/dip when all the mismatches are same and only flanking differs. Percentage is calculated by dividing over the maximum intensity.

16) Press "Make SEL/DiSEL" to run the program.
17) Wait for the SEL/DiSEL to appear. Note that sequences are plotted in the selected order. For Circular SEL sequences are arranged clockwise starting at 12 o’clock position.

Additional information for Circular SEL/DiSEL-
18) When SEL/DiSEL appears with "Data cursor" as default mode of interacting with SEL/DiSEL. Left-click on any peak (or valley) and the sequence will be displayed in the lower-left corner. Hold left-click and drag the pointer to see other sequences on the ring. The sequence in the lower-left corner is divided into 3 parts. The part of the sequence in the green region on either side displays the flanking, and the sequence matching the seed motif is displayed in the center (with different mismatches based on mismatch ring).
19) Use "Zoom In", "Zoom Out", "Pan" and "Rotate 3D" tools to zoom, pan and rotate the plot.
20) To get all the sequences between points A and B on any mismatch ring- click at the point A and then click "Sequences From" button near lower left corner, then select point B on the same mismatch ring and select "Sequences To" button. Sequences are entered into an output file in clockwise order (A to B or B to A, whichever excludes 12 o’clock position). The name of the output files appear next to the button for "Sequences From".
21) The command to generate the same SEL/DiSEL appears on the bottom-right.


COMMAND LINE INPUTS-
Command line can also be used to generate SEL/DiSEL, but it will not have any interactive features like- click on any peak to get corresponding sequence. Example for command line inputs can be seen in commands_1.m file. ssl_1.m program is used for generating SEL/DiSEL via command line.
To plot SEL--
1st input is –as "Input File 1" in GUI.
2nd input is –as "Seed motif" in GUI.
To plot DiSEL--
1st input is - as "Input File 1" in GUI.
2nd input is - as "Input File 2" in GUI.
3rd input is - as "Seed motif" in GUI.

Other optional inputs can also be specified. Optional inputs has to be even numbered, first the name of the optional variable/input and then the value is entered. Following are optional inputs.
‘OutputFile’ - Same as "Output file name" in GUI.
‘Smoothening’ - Same as "Smoothening" in GUI.
‘order’ – Same as "Arrangement" in GUI.
‘ring_start’ - Same as "Lowest mismatch ring" in GUI.
‘ring_stop’ - Same as "Highest mismatch ring" in GUI.
‘BarPlot’ - Same as "Circular/Linear" in GUI.
‘column’ - Same as "Intensity/count column" in GUI.
‘column2’ - In case column of Input File 2 isn't same as Input File 1 column2 is used to define column number for Input File 2.
‘MismPeakDiffPerc’ - Same as "Mismatch Peak" in GUI.
‘FlankPeakDiffPerc’ - Same as "Flanking Peak" in GUI.
‘n_pt’ - To display sequences over the peaks in SEL/DiSEL, if n_pt>=number of sequences in a ring all sequences in that ring are displayed, else only n_pt sequences in each ring are displayed.
‘Thickness’ - To change thickness of each ring.

Output from automated algorithm-
For "Mismatch Peak" - Columns are
1) Mism – Mismatch ring.
2) RingMedianInt – Median intensity of sequences in DiSEL mismatch ring.
3) PeakMismatch – Detected mismatch peak.
4) PosOrNegPeak – If it is a positive or negative peak.
5) MismatchMedianInt – Median intensity of corresponding sequences in mismatch peak.
6) PeakSeqIntPercDiff – Percentage difference between column 5 & 2. Percentage is calculated by dividing over the maximum intensity.
7) PercentagePositiveHits – Percentage positive hits from the selected mismatch peak.
Name of file generated - <File name specified>_peak_mismatches.txt

Output from automated algorithm-
For "Flanking Peak" - Columns are
1) Mism – Mismatch ring in which flanking peak is detected.
2) MismatchedMotif - Flanking peak detected corresponds to this mismatch motif. In 0 mismatch ring - same as motif. 
3) MismatchMedianInt - Median intensity of sequences in the mismatch peak.
4) PeakSeq - Sequence of the Flanking peak
5) PosOrNegPeak - If it is a positive or negative peak.
6) PeakSeqInt - Intensity corresponding to sequence of the flanking peak.
7) PeakSeqIntPercDiff - Percentage difference between column 6 & 3. Percentage is calculated by dividing over the maximum intensity.
Name of file generated - <File name specified>__peak_Flanking.txt

