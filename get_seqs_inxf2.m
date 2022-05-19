function Int_nthmer_map=get_seqs_inxf2(seqs)
seqsc=upper(char(seqs));
seqsc(seqsc==' ')='N';
[num_seqs,l]=size(seqsc);
aa=[1 0 2 0 0 0 3 0 0 0 0 0 0 0 0 0 0 0 0 4 0 0 0 0 0 0];
fives = power(5,0:l-1);
inx=aa(seqsc-64);
inx2=5-aa(seqsc-64);inx2(inx2==5)=0; inx2=inx2(:,end:-1:1);

sum_r=sum(inx2.*fives(ones(num_seqs,1),:),2);
% REMOVING XSs FROM ONE EDGE
for i=1:l
    ix=find(rem(sum_r,5)==0);
    sum_r(ix)=sum_r(ix)/5;
end
Int_nthmer_map= min(sum(inx.*fives(ones(num_seqs,1),:),2),sum_r)+1;
end