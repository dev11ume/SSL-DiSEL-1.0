% TO REMAKE THE SAME FIGURE AS IN PAPER %


%-------------------------------FIGURE 1----------------------------------%

% COMMAND TO GET SEL FOR Gata4 PROTEIN - FIGURE 1b
ssl_1('.\Data\Gata4_csi.txt','wgataa','order',5,'ring_stop',2);
ssl_1('.\Data\Gata4_csi.txt','wgataa','order',5,'ring_stop',2,'Thickness',2);
view([90 90])

% FOR MISMATCH RING 0
ssl_1('.\Data\Gata4_csi.txt','wgataa','order',5,'ring_stop',0);
% FOR MISMATCH RING 1
ssl_1('.\Data\Gata4_csi.txt','wgataa','order',5,'ring_start',1,'ring_stop',1);

% ENTER FOLLOWING COMMAND IN ADDITION TO GET SAME VIEW ANGLE AS IN FIGURE 
axis([-70 70 -70 70 -1 1]); 

disel_1('.\Data\Lhx4_pbm.txt','.\Data\Lhx2_pbm.txt','taatta','ring_stop',3,'column',4,'Thickness',2);



%-----------------------SUPPLEMENTARY FIGURE 1 ---------------------------%

% SUPPLEMENTARY FIGURE 1a- MISMATCH RING 2
ssl_1('.\Data\Gata4_csi.txt','wgataa','order',5,'ring_start',2,'ring_stop',2);
% SUPPLEMENTARY FIGURE 1A- MISMATCH RING 3
ssl_1('.\Data\Gata4_csi.txt','wgataa','order',5,'ring_start',3,'ring_stop',3);
% SUPPLEMENTARY FIGURE 1A- SELs AS BARPLOTs
ssl_1('.\Data\Gata4_csi.txt','wgataa','order',5,'BarPlot',1);

% SUPPLEMENTARY FIGURE 1b- SEL
% FOR MISMATCH RING 0
ssl_1('.\Data\Gata4_csi.txt','wgataa','order',5,'ring_stop',0,'n_pt',10000);
view (90,90);
% FOR MISMATCH RING 1
ssl_1('.\Data\Gata4_csi.txt','wgataa','order',5,'ring_start',1,'ring_stop',1,'n_pt',10000);
view (90,90);
% THEN ZOOM-IN USING MATLAB ZOOM-IN TOOL


%---------------------------- FIGURE 5 -----------------------------------%

% SEL- PBM - Lhx2
ssl_1('.\Data\Lhx2_pbm.txt','taatta','ring_stop',3,'column',4);
% SEL- PBM - Lhx4
ssl_1('.\Data\Lhx4_pbm.txt','taatta','ring_stop',3,'column',4);
% DiSEL- PBM - Lhx2 Over Lhx4
disel_1('.\Data\Lhx2_pbm.txt','.\Data\Lhx4_pbm.txt','taatta','ring_stop',3,'column',4,'MismPeakDiffPerc',5);
% DiSEL- PBM - Lhx4 Over Lhx2
disel_1('.\Data\Lhx4_pbm.txt','.\Data\Lhx2_pbm.txt','taatta','ring_stop',3,'column',4);



%-----------------------SUPPLEMENTARY FIGURE 5 & 6-----------------------%

% SEL- PBM - Rxra
ssl_1('.\Data\Rxra_pbm.txt','gggtca','ring_stop',3,'column',4);
% SEL- PBM - Hnf4a
ssl_1('.\Data\Hnf4a_pbm.txt','gggtca','ring_stop',3,'column',4);
% DiSEL- PBM - Rxra Over Hnf4a
disel_1('.\Data\Rxra_pbm.txt','.\Data\Hnf4a_pbm.txt','gggtca','ring_stop',3,'column',4,'MismPeakDiffPerc',10);
% DiSEL- PBM - Hnf4a Over Rxra
disel_1('.\Data\Hnf4a_pbm.txt','.\Data\Rxra_pbm.txt','gggtca','ring_stop',3,'column',4);

% SEL- PBM - Irf5
ssl_1('.\Data\Irf5_pbm.txt','cgaaac','ring_stop',3,'column',4);
% SEL- PBM - Irf4
ssl_1('.\Data\Irf4_pbm.txt','cgaaac','ring_stop',3,'column',4);
% DiSEL- PBM - Irf5 Over Irf4
disel_1('.\Data\Irf5_pbm.txt','.\Data\Irf4_pbm.txt','cgaaac','ring_stop',3,'column',4,'MismPeakDiffPerc',10);
% DiSEL- PBM - Irf4 Over Irf5
disel_1('.\Data\Irf4_pbm.txt','.\Data\Irf5_pbm.txt','cgaaac','ring_stop',3,'column',4);

% ENTER FOLLOWING COMMAND IN ADDITION TO GET SAME VIEW ANGLE AS IN FIGURE 
axis([-50 50 -50 50 -1 1]);


%-----------------------------------END-----------------------------------%