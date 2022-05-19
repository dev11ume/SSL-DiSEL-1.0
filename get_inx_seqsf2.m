function seqs=get_inx_seqsf2(inx,max_nmer)
mot='xACGT';
r=rem(floor((inx-1)*power(5,1-max_nmer:0)),5)+1;
seqs=cellstr(mot(r(:,end:-1:1)));
end