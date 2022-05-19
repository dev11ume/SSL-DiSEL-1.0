% PROGRAM TO GENERATE LANDSCAPE
function varargoutx=sslc_1(inp,motif,varargin)
% try
    
    % DEFAULT INPUTS
    op='0';
    l_l=1;
    sm=0.1;
    sel=1;
    ring_start=0;
    ring_stop=-1;
    BarPlot=0;
    n_pt=0;
    column=3;
    column2=3;
    full_op=0;
    from_gui=0;
    h_msgbox=0;
    invrt=0;
    MismPeakDiffPerc=25;
    FlankPeakDiffPerc=50;
    
    if rem(length(varargin),2)==0
        disel=0;
        st=1;
    else
        disel=1;
        inp2=varargin{1};
        st=2;
    end
    column2exist=0;
    for i=st:2:length(varargin)
        switch varargin{i}
            case 'OutputFile'
                op=varargin{i+1};
            case 'Thickness'
                l_l=varargin{i+1};
            case 'Smoothening'
                sm=varargin{i+1};
            case 'MismPeakDiffPerc'
                MismPeakDiffPerc=varargin{i+1};
            case 'FlankPeakDiffPerc'
                FlankPeakDiffPerc=varargin{i+1};
            case 'order'
                sel=varargin{i+1};
            case 'ring_start'
                ring_start=varargin{i+1};
            case 'ring_stop'
                ring_stop=varargin{i+1};
            case 'BarPlot'
                BarPlot=varargin{i+1};
            case 'n_pt'
                n_pt=varargin{i+1};
            case 'column'
                column=varargin{i+1};
            case 'column2'
                column2=varargin{i+1};
                column2exist=1;
            case 'full_op'
                full_op=varargin{i+1};
            case 'from_gui'
                from_gui=varargin{i+1};
            case 'h_msgbox'
                h_msgbox=varargin{i+1};
            case 'invert'
                invrt=varargin{i+1};
            otherwise
                error('Wrong inputs');
        end
    end
%     sel=9;
    
    if column2exist==0
        column2=column;
    end
    if ~isempty(find(motif=='''',1))
        motif=eval(motif);
    end
    
    motifx='[';
    for i=1:size(motif,1)-1
        motifx=[motifx '''' motif(i,:) ''';'];
    end
    motifx=[motifx '''' motif(size(motif,1),:) ''']'];
    % GENERATE COMMAND LINE RUN
    if disel
        comm_str=['COMMAND LINE: disel_1(''' inp ''',''' inp2 ''',' motifx ...
            ',''OutputFile'',''' op ...
            ''',''Smoothening'',' num2str(sm) ...
            ',''Thickness'',' num2str(l_l) ...
            ',''n_pt'',' num2str(n_pt) ...
            ',''order'',' num2str(sel) ...
            ',''ring_start'',' num2str(ring_start) ...
            ',''ring_stop'',' num2str(ring_stop) ...
            ',''BarPlot'',' num2str(BarPlot) ...
            ',''invert'',' num2str(invrt) ...
            ',''column'',' num2str(column) ...
            ',''column2'',' num2str(column2) ...
            ',''MismPeakDiffPerc'',' num2str(MismPeakDiffPerc) ...
            ',''FlankPeakDiffPerc'',' num2str(FlankPeakDiffPerc) ...
            ');'];
    else
        comm_str=['COMMAND LINE: ssl_1(''' inp ''',' motifx ...
            ',''OutputFile'',''' op ...
            ''',''Smoothening'',' num2str(sm) ...
            ',''Thickness'',' num2str(l_l) ...
            ',''n_pt'',' num2str(n_pt) ...
            ',''order'',' num2str(sel) ...
            ',''ring_start'',' num2str(ring_start) ...
            ',''ring_stop'',' num2str(ring_stop) ...
            ',''BarPlot'',' num2str(BarPlot) ...
            ',''column'',' num2str(column) ...
            ',''column2'',' num2str(column2) ...
            ',''MismPeakDiffPerc'',' num2str(MismPeakDiffPerc) ...
            ',''FlankPeakDiffPerc'',' num2str(FlankPeakDiffPerc) ...
            ');'];
    end
    
    if BarPlot==1 && from_gui~=0
        delete(from_gui);
    end
    
    % TO CONVERT DEGENERATE NUCLEOTIDES TO ACGTs
    motif_up=upper(motif);
    motif_deg=motif_degenerate_1(motif_up);
    
    if invrt==1 && disel
        x=inp;
        inp=inp2;
        inp2=x;
        x=column;
        column=column2;
        column2=x;
    end
    
    %READ FILE AND MOTIF INFORMATION
    [n,mism,pos_mis_mot,match_to_mot,mot_fr,F,R,Int,ls2,lm]=...
        read_datasets_1(inp,motif_deg,column-2);
    if disel
        [n2,mism2,pos_mis_mot2,match_to_mot2,mot_fr2,F2,R2,Int2,ls22,lm2]=...
            read_datasets_1(inp2,motif_deg,column2-2);
        % ADDED TO REMOVE ASSUMPTION F=F2
        ls=ls2-2*(lm-1);
        if ~isequal(F,F2)
            ix1=get_seqs_inxf2(F(:,lm:end-lm+1));
            ix2=get_seqs_inxf2(F2(:,lm:end-lm+1));
            [~,b]=sort(ix1);
            [~,c]=sort(ix2);
            seqsx=get_inx_seqsf2(ix1(b),ls);
            seqsx2=get_inx_seqsf2(ix2(c),ls);
            if ~isequal(seqsx,seqsx2)
                error('Different sequences in the two files');
            end
            Int=Int(b);F=F(b,:);R=R(b,:);
            Int2=Int2(c);F2=F;R2=R;
        end
    end
    
    %ARRANGE THE SEQUENCES AND GET MISMATCH
    [Int_indx,Ucode3,Us3,Us3r,l,ln]=...
        get_mismatches_2(n,mism,pos_mis_mot,match_to_mot,...
        mot_fr,F,R,ls2,lm,motif_deg,sel);
    if disel
        [Int_indx2,~,~,~,~]=...
            get_mismatches_2(n2,mism2,pos_mis_mot2,...
            match_to_mot2,mot_fr2,F2,R2,ls22,lm2,motif_deg,sel);
    end
    
    ring_start=ring_start+1; ring_stop=ring_stop+1;
    if ring_start==0
        ring_start=1;
    end
    if ring_stop==0
        ring_stop=length(l);
    end
    
    if ring_stop<ring_start
        error(['Maximum mismatch ring has to be greater ' ...
            'than or equal to Minimum mismatch ring to be displayed']);
    end
    
    % FORCING MEAN=0 AND MAX=1 (FOR RING 0 MISMATCH TO RING STOP)
    Int=(Int-mean(Int));
    Int=Int/max(Int(Int_indx(ln(1,1):ln(ring_stop,2))));
    if disel
        Int2=(Int2-mean(Int2));
        Int2=Int2/max(Int2(Int_indx2(ln(1,1):ln(ring_stop,2))));
    end
    
    % SORTING INTENSITY IN ORDER OF SEQUENCES ARRANGEMENT
    if disel
        Intx=Int(Int_indx)-Int2(Int_indx2);
    else
        Intx=Int(Int_indx);
    end
    
    get_peaks_mismatch1_4(MismPeakDiffPerc,Ucode3,Intx,lm,motif_deg,op,ring_stop-1,sel,ls2,disel);
    get_peaks_flanking1_3(FlankPeakDiffPerc,Ucode3,Intx,ln,lm,motif_deg,Us3,op,ring_stop-1,sel,ls2);
    
    %PLOT LANDSCAPE LINEAR OR CIRCULAR
    if (BarPlot==0)
        [X,Y,Z,f]=draw_ssl_1(Intx,Us3,Us3r,lm,sm,l_l,op,n,l,ln,ls2,...
            ring_start,ring_stop,n_pt,comm_str);
    else
        draw_linear_ssl_1(Intx,Us3,lm,sm,l,ln,ls2,ring_start,ring_stop,BarPlot);
        X=0;Y=0;Z=0;f=0;
    end
    if full_op==1
        varargoutx=[{op};{f};{Intx};{Us3};{Ucode3};{l};{ln};{lm};{ls2};{X};{Y};{Z};{comm_str}];
    else
        varargoutx=cell(1,1);
    end
% catch ME
%     if from_gui~=0
%         delete(from_gui);
%         delete(h_msgbox);
%     end
%     disp('Error occurred');
%     errordlg(ME.message);
% end

end

