
function get_peaks_mismatch1_4(MismPeakDiffPerc,Ucode3,Intx,lm,motif_deg,op,max_mism,sel,ls2,disel)

fid=fopen([op '_peak_mismatches.txt'],'w');
fprintf(fid,['Mism\tRingMedianInt\tPeakMismatch\tPosOrNegPeak\t' ...
    'MismatchMedianInt\tPeakSeqIntPercDiff\tPercentagePositiveHits\n']);

% ALL POSSIBLE MISMATCHES
% NOTE: XXXXXX CAN BE FOR 0 MISMATCH AS WELL AS HIGHER WHEN MOTIFS IS PARTIALLY IN SEQUENCE
if sel>8
    add_len=lm;
else
    add_len=0;
end
if sel==3||sel==4||sel==11||sel==12
    add_len=add_len+ls2-lm+1;
end
if sel==7||sel==8||sel==15||sel==16
    add_len=add_len+1;
end
if sel>8
    add_len2=0;
else
    add_len2=ls2+lm+1;
    if sel>4
        add_len2=add_len2+1;
    end
end
[~,IA_mism_base,IC_mism_base]=unique(Ucode3(:,[1 1+lm+1+add_len:1+lm+lm+add_len 2+add_len2:1+lm+add_len2]),'rows');
C_mism_base=char(Ucode3(IA_mism_base,1+lm+1+add_len:1+lm+lm+add_len));
C_mism_base2=char(Ucode3(IA_mism_base,1+lm+1+add_len:1+lm+lm+add_len));
C_mism_base_mot=char(Ucode3(IA_mism_base,2+add_len2:1+lm+add_len2));
ix_tochange=Ucode3(IA_mism_base,lm+1+add_len:-1:2+add_len)==0;
C_mism_base2(ix_tochange)=C_mism_base_mot(ix_tochange);
med_int_mism_bases=zeros(length(C_mism_base),1);
med_int_mism_bases_ints=cell(length(C_mism_base),1);
map_mism_bases_to_numb_mis=Ucode3(IA_mism_base,1);
for j=1:length(C_mism_base)
    med_int_mism_bases(j)=median(Intx(IC_mism_base==j));
    med_int_mism_bases_ints{j}=Intx(IC_mism_base==j);
end

% NUMBER OF MISMATCHES
max_Int=max(abs(Intx));
mismatches_all=Ucode3(:,1);
[C,~,IC]=unique(mismatches_all);
med_int_mism=zeros(length(C),1);
peaks_ith_mism=cell(length(C),1);
for i=2:min(length(C),max_mism+1)
    med_int_mism(i)=median(Intx(IC==i));
    ix=find(map_mism_bases_to_numb_mis==(i-1));
    med_ith_mism=med_int_mism_bases(ix);
    med_ith_mism_ints=med_int_mism_bases_ints(ix);
    if disel
        comp_val=0;
    else
        comp_val=med_int_mism(i);
    end
    diff_med=med_ith_mism-comp_val;
    [diff_med_sort,ix_sort]=sort(abs(diff_med),'descend');
    peaks_ith_mism{i}=find((abs(diff_med_sort)/max_Int*100)>MismPeakDiffPerc);
    for k=1:length(peaks_ith_mism{i})
        fprintf(fid,'%d\t%f\t',(i-1),med_int_mism(i));
        perc_diff=(med_ith_mism(ix_sort(peaks_ith_mism{i}(k)))-comp_val)/max_Int*100;
        if (med_ith_mism(ix_sort(peaks_ith_mism{i}(k)))-comp_val)>0
            tot_pos=length(find(med_ith_mism_ints{ix_sort(peaks_ith_mism{i}(k))}>=comp_val));
            tot_neg=length(find(med_ith_mism_ints{ix_sort(peaks_ith_mism{i}(k))}<comp_val));
            perc_pos_hits=tot_pos/(tot_pos+tot_neg)*100;
            fprintf(fid,'%s\t+\t%f\t%f\t%3.2f\n',C_mism_base2(ix(ix_sort(peaks_ith_mism{i}(k))),:),...
                med_ith_mism(ix_sort(peaks_ith_mism{i}(k))),perc_diff,perc_pos_hits);
        else
            tot_pos=length(find(med_ith_mism_ints{ix_sort(peaks_ith_mism{i}(k))}<=comp_val));
            tot_neg=length(find(med_ith_mism_ints{ix_sort(peaks_ith_mism{i}(k))}>comp_val));
            perc_pos_hits=tot_pos/(tot_pos+tot_neg)*100;
            fprintf(fid,'%s\t-\t%f\t%f\t%3.2f\n',C_mism_base2(ix(ix_sort(peaks_ith_mism{i}(k))),:),...
                med_ith_mism(ix_sort(peaks_ith_mism{i}(k))),perc_diff,perc_pos_hits);
        end
    end
end

fclose(fid);
