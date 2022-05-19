
function get_peaks_flanking1_3(FlankPeakDiffPerc,Ucode3,Intx,ln,lm,motif_deg,Us3,op,max_mism,sel,ls2)

fid=fopen([op '_peak_Flanking.txt'],'w');

fprintf(fid,'Mism\tMismatchedMotif\tMismatchMedianInt\tPeakSeq\tPosOrNegPeak\tPeakSeqInt\tPeakSeqIntPercDiff\n');


% ALL POSSIBLE MISMATCHES
max_Int=max(abs(Intx));
% NOTE: XXXXXX CAN BE FOR 0 MISMATCH AS WELL AS HIGHER WHEN MOTIFS IS PARTIALLY IN SEQUENCE
if sel>8
    add_len=size(motif_deg,2);
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
[~,IA_mism_base,IC_mism_base]=unique(Ucode3(1:ln(max_mism+1,2),[1 1+lm+1+add_len:1+lm+lm+add_len  2+add_len2:1+lm+add_len2]),'rows');
C_mism_base=char(Ucode3(IA_mism_base,1+lm+1+add_len:1+lm+lm+add_len));
C_mism_base2=char(Ucode3(IA_mism_base,1+lm+1+add_len:1+lm+lm+add_len));
C_mism_base_mot=char(Ucode3(IA_mism_base,2+add_len2:1+lm+add_len2));
ix_tochange=Ucode3(IA_mism_base,lm+1+add_len:-1:2+add_len)==0;
C_mism_base2(ix_tochange)=C_mism_base_mot(ix_tochange);
med_int_mism_bases=zeros(length(C_mism_base),1);
peaks_jth_flank=cell(length(C_mism_base),1);
map_mism_bases_to_numb_mis=Ucode3(IA_mism_base,1);
[~,sort_ix1]=sort(map_mism_bases_to_numb_mis,'ascend');

for j=1:length(C_mism_base)
    ix_seqs=find(IC_mism_base==sort_ix1(j));
    med_int_mism_bases(j)=median(Intx(ix_seqs));
    diff_med_peak=Intx(ix_seqs)-med_int_mism_bases(j);
    [diff_med_peak_sort,sort_ix2]=sort(abs(diff_med_peak),'descend');
    peaks_jth_flank{j}=find((abs(diff_med_peak_sort)/max_Int*100)>FlankPeakDiffPerc);
    if ~isempty(peaks_jth_flank{j})
        for k=1:length(peaks_jth_flank{j})
            fprintf(fid,'%d\t%s\t%f\t',map_mism_bases_to_numb_mis(sort_ix1(j)),...
                C_mism_base2(sort_ix1(j),:),med_int_mism_bases(j));
            perc_diff=(Intx(ix_seqs(sort_ix2(peaks_jth_flank{j}(k))))-med_int_mism_bases(j))/max_Int*100;
            if perc_diff>0
                fprintf(fid,'%s\t+\t%f\t%f\n',Us3(ix_seqs(sort_ix2(peaks_jth_flank{j}(k))),lm:end-lm+1),...
                    Intx(ix_seqs(sort_ix2(peaks_jth_flank{j}(k)))),perc_diff);
            else
                fprintf(fid,'%s\t-\t%f\t%f\n',Us3(ix_seqs(sort_ix2(peaks_jth_flank{j}(k))),lm:end-lm+1),...
                    Intx(ix_seqs(sort_ix2(peaks_jth_flank{j}(k)))),perc_diff);
            end
        end
    end
end

fclose(fid);
